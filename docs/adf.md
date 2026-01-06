### Steps

1. In the search bar, type Azure Data Factory, Click + Create.
2. Fill Basic Details
    |Field|	Example|
    |--|--|
    |Subscription|	Your subscription|
    |Resource Group|	de-project-rg|
    |Name|	de-adf-pipeline|
    |Region|	Central India|
    |Version|	V2 (mandatory)|
3. Click Review + Create, then Create.
4. Open the created Data Factory, Click Launch Studio.

### ADF Pipeline Flow

### Create Self-Hosted Integration Runtime (SHIR)

In ADF Studio:
1. Open Azure Data Factory
2. Click Manage (⚙️) → Integration runtimes
3. Click + New
4. Select Self-Hosted
5. Click Continue
6. Give name: onPremisePostgreSQLRuntime, Click Create.

### Install SHIR on On-Prem Server / VM

1. Copy the authentication key
2. Download the SHIR installer
    - Install it on: On-prem server OR VM that can access PostgreSQL
3. Paste the authentication key during setup
4. Confirm status shows Running

SHIR is now connected to ADF

### Create Azure Key Vault Linked Service in ADF

In ADF Studio
1. Go to Manage (⚙️) → Linked services
2. Click + New: Search for Key Vault -> Select Azure key vault -> Click Continue
3. Configure Linked Service, Fill the form:

    | Field               | Example                                     |
    | ------------------- | ------------------------------------------- |
    | Name                | ls_azure_key_vault                          |
    | Azure key vault selection method | From Azure subscription       |
    | Azure subscription         | Choose your subscription |
    | Azure key vault name       | Name of the azure key vault you had created earlier                                      |
    | Authentication method            | System-assigned managed identity                               |
4. Test Connection, and if successfull click on create. 
       

### Create PostgreSQL Linked Service in ADF (For Source)

In ADF Studio
1. Go to Manage (⚙️) → Linked services
2. Click + New: Search for PostgreSQL -> Select PostgreSQL -> Click Continue
3. Configure Linked Service, Fill the form:

    | Field               | Example                                     |
    | ------------------- | ------------------------------------------- |
    | Name                | ls_onprem_postgres                          |
    | Integration Runtime | **SelfHosted (onPremisePostgreSQLRuntime)**       |
    | Server name         | `127.0.0.1` |
    | Database name       | `ecom_data`                                  |
    | Username            | `adf_user`                             |
    | Password            | `********`                                  |
    | Port                | `5432`                                      |

4. Test Connection: Click Test connection. Ensure status is Successful
5. Click Create


### Create ADLS Gen2 Linked Service in ADF (For Destination)

In ADF Studio
1. Go to Manage (⚙️) → Linked services
2. Click + New: Search for Azure Data Lake Storage Gen2 -> Select Azure Data Lake Storage Gen2 -> Click Continue
3. Configure Linked Service, Fill the form:

    | Field               | Example                                     |
    | ------------------- | ------------------------------------------- |
    | Name                | ls_adlsgen2_sink                          |
    | Integration Runtime | **AutoResolveIntegrationRuntime**       |
    | Authentication type         | System-assigned managed identity |
    | Account selection method       | From Azure subscription                                  |
    | Azure subscription            | Your Subscription                            |
    | Storage account name            | delakehouse001                                  |

4. Test Connection: Click Test connection. Ensure status is Successful
5. Click Create

### Create Dataset

In ADF Studio, Go to Author Section. Click Author (✏️) on the left, then expand Datasets, Click + (Add new dataset). Select Dataset Type:
    
- PostgreSQL
    1. Choose PostgreSQL. Click Continue
    2. Configure:

        | Field          | Example            |
        | -------------- | ------------------ |
        | Name           | ds_postgres_source |
        | Linked Service | ls_onprem_postgres |
        | Table(Optional)|      |
    
- ADLS Gen2
    1. Choose ADLS Gen2. Click Continue
    2. Select File Type: parquet
    3. Configure:

        | Field          | Example            |
        | -------------- | ------------------ |
        | Name           | ds_adls_parquet |
        | Linked Service | ls_adlsgen2_sink |
        | Import Schema|    None  |

    4. Configure: Container: bronze, Directory: ''/, File name: ''


### Use in Pipeline

Example:

1. Go to Author
2. Create Pipeline
3. Add Copy Data activity
4. Source → PostgreSQL (this linked service)
5. Sink → ADLS / Azure SQL / Blob

In this project will be using a pipeline, which will be used to get metadata(lookup) from db to fetch all table name. Then will be used with foreach + copy activity to pull data from database and push it to bronze container in parquet format. Will be using logic app to send email on success/failure of pipeline.

- Lookup Activity

    What it does:
    1. Reads a small dataset (row or rows) from a source
    2. Returns the result as JSON output
    3. Used to drive pipeline logic dynamically

    Use in this project:
    This activity is used here to get list of tables available in the database.
    ```
    SELECT
    table_schema,
    table_name
    FROM information_schema.tables
    WHERE table_type = 'BASE TABLE'
    AND table_schema NOT IN ('pg_catalog', 'information_schema')
    ORDER BY table_schema, table_name;
    ```

- ForEach Activity

    What it does:
    1. Loops over a list (array)
    2. Executes inner activities once per item
    3. Can run sequentially or in parallel

    Use in this project:
    This activity iterates over each table name and pass that tablename to copy activity.

- Copy Activity

    what it does:
    1. move data from a source to a sink (destination).

    Use in this project:
    This activity copies the data from postgreSQL db and writes that data into adls gen2 bronze container in parquet format.


- Web Activity

    What it does:
    1. Makes HTTP/REST API calls
    2. Supports GET, POST, PUT, DELETE
    3. Used to interact with external services

    Use in this project:
    This activity is used with logic app, it notifies user if pipeline fails or succeeds.