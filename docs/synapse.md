### Steps:

1. Search Azure Synapse Analytics, Click + Create.
2. Basic Information:

| Field          | Example           |
| -------------- | ----------------- |
| Subscription   | Your subscription |
| Resource Group | de-project-rg     |
| Workspace name | de-synapse-ws     |
| Region         | Central India     |

3. Configure Data Lake: 
    1. Select ADLS Gen2 account
    2. Choose filesystem (container), e.g. synapse
    3. Synapse creates required folders automatically. Click Next
4. In security, set your authentication credential for SQL Pool.
    1. Can choose microsoft entra id or local or both


### Pool

A "Pool" refers to the specific compute resources reserved or allocated to process your data.

|Feature|Dedicated SQL Pool|Serverless SQL Pool|Apache Spark Pool|
|--|--|--|--|
|Scaling|Manual / Scripted|Automatic|Automatic (Auto-scale)|
|Language|T-SQL|T-SQL|Python, Scala, Spark SQL, R|
|Storage|Relational (Local SSD)|Data Lake (Parquet, CSV, JSON)|Data Lake (Any Spark format)|
|Best Use Case|Enterprise Reporting|Data Exploration / Ad-hoc|Data Science / Complex ETL|
|Cost Model|Hourly (by DWU)|Per TB Scanned|Hourly (by Node size)|

**Create SQL DB**
1. On left pane, click on data -> + create sql database.
2. Check on serverless, and name your db.
3. In left pane, click on develop to create sql scripts.