## Sign in to Azure Portal

- Go to https://portal.azure.com
- Log in with your Azure account

## Resource Group

1. Go to Azure Portal. In the search bar at the top, type Resource groups, click Resource groups from the results.
2. On the Resource Groups page, click + Create.
3. You will see a form. Fill it as follows:
    - Subscription → Select your Azure subscription.
    - Resource Group Name → Example: data-engineering-rg.
    - Choose a region close to you: Central India.
    - Review and Create.

*Use this Resource group to create azure resouces inside it.*

## Azure Data Factory

It's a data integration and orchestration service, lets you ingest, transform, and move data from multiple sources to destinations (data lakes, data warehouses, databases) without managing servers.

- What ADF is commonly used for:
    1. Ingest data from APIs, databases, files, SaaS apps.
    2. Move data into Azure Data Lake Storage, Synapse, SQL DB.
    3. Orchestrate workflows (schedule, retry, dependency handling).
    4. Trigger Databricks, Spark, SQL, Stored Procedures.

- Core Concepts:

    |Concept|	Meaning|
    |--|--|
    |Linked Service|	Connection to a data source or destination|
    |Dataset|	Represents data structure (table, file, folder)|
    |Pipeline|	Logical workflow of activities|
    |Activity|	A task (Copy, Data Flow, Notebook, SQL, etc.)|
    |Trigger|	Schedule or event to run pipeline|

**What is Integration Runtime in Azure Data Factory?**

In Azure Data Factory, an Integration Runtime (IR) is the compute infrastructure that ADF uses to move, transform, and process data. In simple terms, Integration Runtime is where your ADF pipeline actually runs. ADF pipelines are just definitions. Integration Runtime does the real work.

Why it is needed?

ADF needs compute to:
1. Copy data from source → destination
2. Run Data Flows (Spark-based transformations)
3. Connect to on-premises / private networks
4. Execute activities like:
    1. Copy Activity
    2. Data Flow
    3. Lookup
    4. Stored Procedure

Types of Integration Runtime:

- Azure Integration Runtime (Default)
    1. Fully managed compute by Azure which runs inside Azure.
    2. Used for:
        1. Cloud-to-cloud data movement
        2. Azure SQL → ADLS
        3. REST API → Blob Storage

- Self-Hosted Integration Runtime (SHIR) 
    1. It's installed on On-prem VM, Local server, or Private network VM.
    2. Used for:
        1. On-premises data sources
        2. Private networks

*Will be using the second option for this project.*

[Steps to create ADF](./)

## ADLS Gen2

It's optimized data lake storage designed for big data analytics and data engineering workloads, built on top of Azure Blob Storage but enhanced with:
    1. Hierarchical namespace (HNS) → folders & directories
    2. POSIX-style ACLs → fine-grained access control
    3. High throughput for analytics engines
In data engineering it acts as a data lake (Bronze / Silver / Gold layers).

- Integrates with:
    1. Azure Data Factory
    2. Azure Databricks
    3. Azure Synapse Analytics
    4. Supports Parquet, CSV, JSON, Delta Lake

[Steps to create ADF](./)

## Azure Key Vault

It's used to store and manage sensitive information, such as:
    1. 🔐 Secrets (passwords, connection strings, API keys)
    2. 🔑 Cryptographic keys (encryption keys)
    3. 📜 Certificates (SSL/TLS)

- Why Key Vault Is Important (Data Engineering & Cloud)

Secure credentials for:
    1. Azure Data Factory
    2. Azure Databricks
    3. Azure Synapse Analytics
    4. Supports secret rotation
    5. Integrated with Azure IAM (RBAC)
    6. Prevents hardcoding secrets in pipelines

[Steps to create AKV](./)

## Logic Apps

Azure Logic Apps is a cloud-based "Low-Code/No-Code" platform used to build automated workflows that connect different apps, data, and systems.

**Core Components**

Every Logic App follows a simple "If This, Then That" logic:
1. Trigger: The event that starts the workflow (e.g., "When a new email arrives" or "Every hour").
2. Actions: The steps that follow (e.g., "Create a file in SharePoint" or "Post a message to Slack").
3. Connectors: Pre-built bridges to 1,400+ services (SQL Server, Office 365, SAP, Dropbox, etc.).

*Here it will be used for sending email for adf pipeline activity(if it's a failure or success).*

[Steps to create Logic App](./)

## Azure Monitor

Azure Monitor is a central hub that collects and analyzes telemetry (logs and metrics) from all your Azure and on-premises resources.

While Logic Apps act on events, Azure Monitor observes them. For Azure Data Factory, it is the tool that tracks how many pipelines succeeded, how much memory the Integration Runtime used, and triggers alerts when things break.

Go to Monitor -> metrics and select the adf. Then filter based on pipeline's success or failure.

## Azure Databricks

It's cloud-based analytics platform built on Apache Spark, optimized for big data processing, ETL, and machine learning on Microsoft Azure.

**Why Databricks is Important**

1. Distributed processing with Apache Spark
2. Ideal for heavy transformations (Silver → Gold)
3. Native integration with: Azure Data Lake Storage Gen2
4. Supports Delta Lake (ACID transactions on data lakes)
5. Scales automatically

[Steps to create Databricks workspace](./)

## Azure Synapse Analytics

It's an end-to-end analytics platform from Microsoft Azure that brings together:

1. Data warehousing (SQL)
2. Big data analytics (Spark)
3. Data integration
4. Analytics & BI access

**Why Synapse Is Important (Data Engineering)**

1. Query data directly from ADLS Gen2 (no data movement)
2. Supports lakehouse architecture
3.Works seamlessly with:
    1. Azure Data Factory
    2. Azure Databricks
    3. Azure Data Lake Storage Gen2
    4.Power BI
5. Handles TB–PB scale analytics

**Core Components**

| Component           | Purpose                            |
| ------------------- | ---------------------------------- |
| Synapse Workspace   | Central analytics environment      |
| Dedicated SQL Pool  | MPP data warehouse                 |
| Serverless SQL Pool | Query data in lake (pay-per-query) |
| Apache Spark Pool   | Big data processing                |
| Synapse Studio      | Web UI                             |


[Steps to create Synapse Analytics workspace](./)