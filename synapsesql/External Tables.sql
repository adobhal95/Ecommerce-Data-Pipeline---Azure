-- In Azure Synapse Analytics, an External Table acts as a pointer to data stored outside the database—
-- typically in Azure Data Lake Storage (ADLS) or Azure Blob Storage.
-- While a regular (internal) table stores the data inside the Synapse SQL engine,
-- an external table keeps the data in your folders (as Parquet, CSV, or JSON) while allowing you to query it using standard T-SQL as if it were a local table.

-- OPENROWSET is a powerful T-SQL function 
-- used primarily by the Serverless SQL Pool to read data directly 
-- from files stored in Azure Data Lake Storage (ADLS)
-- Think of it as a "bridge" that allows you 
-- to use standard SQL queries on raw files like CSV, Parquet, or JSON.
-- create master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD ='password'; -- to access data anywhere

--  create the database-scoped credential.
--  The credential stores authentication information required to connect to an external resource.
--  allows synapse to connect with other azure services
CREATE DATABASE SCOPED CREDENTIAL onpremdb_credential
WITH
IDENTITY = 'Managed Identity';


CREATE EXTERNAL DATA SOURCE MyGoldLake
WITH ( LOCATION = 'https://delakehouse.dfs.core.windows.net/gold',CREDENTIAL=onpremdb_credential);

CREATE EXTERNAL DATA SOURCE MySilverLake
WITH ( LOCATION = 'https://delakehouse.dfs.core.windows.net/silver',CREDENTIAL=onpremdb_credential);

CREATE EXTERNAL FILE FORMAT ParquetFileFormat
WITH (  
    FORMAT_TYPE = PARQUET,  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'  
);

-- Orders Table

CREATE EXTERNAL TABLE GOLD.EXT_Orders
WITH (
    LOCATION = '/orders/',             -- Added trailing slash
    DATA_SOURCE = MyGoldLake,
    FILE_FORMAT = ParquetFileFormat       -- Synapse will write as Parquet files
)
AS 
SELECT * FROM OPENROWSET(
    BULK '/orders/',            -- use relative path if possible
    DATA_SOURCE = 'MySilverLake', -- Use a Data Source for the source
    FORMAT = 'DELTA'
) AS OrderExtTable;

-- Order_Items Table

CREATE EXTERNAL TABLE GOLD.EXT_Order_Items
WITH (
    LOCATION = '/order_items/',             -- Added trailing slash
    DATA_SOURCE = MyGoldLake,
    FILE_FORMAT = ParquetFileFormat       -- Synapse will write as Parquet files
)
AS 
SELECT * FROM OPENROWSET(
    BULK '/order_items_df/',            -- use relative path if possible
    DATA_SOURCE = 'MySilverLake', -- Use a Data Source for the source
    FORMAT = 'DELTA'
) AS Order_Items_ExtTable;

-- Products Table

CREATE EXTERNAL TABLE GOLD.EXT_Products
WITH (
    LOCATION = '/products/',             -- Added trailing slash
    DATA_SOURCE = MyGoldLake,
    FILE_FORMAT = ParquetFileFormat       -- Synapse will write as Parquet files
)
AS 
SELECT * FROM OPENROWSET(
    BULK '/products/',            -- use relative path if possible
    DATA_SOURCE = 'MySilverLake', -- Use a Data Source for the source
    FORMAT = 'DELTA'
) AS ProductsExtTable;

-- Order_Item_Refunds Table

CREATE EXTERNAL TABLE GOLD.EXT_Order_Item_Refunds
WITH (
    LOCATION = '/order_item_refunds/',             -- Added trailing slash
    DATA_SOURCE = MyGoldLake,
    FILE_FORMAT = ParquetFileFormat       -- Synapse will write as Parquet files
)
AS 
SELECT * FROM OPENROWSET(
    BULK '/order_item_refunds/',            -- use relative path if possible
    DATA_SOURCE = 'MySilverLake', -- Use a Data Source for the source
    FORMAT = 'DELTA'
) AS Order_Item_Refunds_ExtTable;

-- Website_Sessions

CREATE EXTERNAL TABLE GOLD.EXT_Website_Sessions
WITH (
    LOCATION = '/website_sessions/',             -- Added trailing slash
    DATA_SOURCE = MyGoldLake,
    FILE_FORMAT = ParquetFileFormat       -- Synapse will write as Parquet files
)
AS 
SELECT * FROM OPENROWSET(
    BULK '/website_sessions/',            -- use relative path if possible
    DATA_SOURCE = 'MySilverLake', -- Use a Data Source for the source
    FORMAT = 'DELTA'
) AS Website_Sessions_ExtTable;

-- Website_Pageviews

CREATE EXTERNAL TABLE GOLD.EXT_Website_Pageviews
WITH (
    LOCATION = '/website_pageviews/',             -- Added trailing slash
    DATA_SOURCE = MyGoldLake,
    FILE_FORMAT = ParquetFileFormat       -- Synapse will write as Parquet files
)
AS 
SELECT * FROM OPENROWSET(
    BULK '/website_pageviews/',            -- use relative path if possible
    DATA_SOURCE = 'MySilverLake', -- Use a Data Source for the source
    FORMAT = 'DELTA'
) AS Website_Pageviews_ExtTable;