### Steps:

1. Search Azure Databricks, Click + Create.
2. Fill Details:
    | Field          | Example           |
    | -------------- | ----------------- |
    | Subscription   | Your subscription |
    | Resource Group | de-project-rg     |
    | Workspace name | de-databricks-ws  |
    | Region         | Central India     |
    | Pricing tier   | Premium          |
3. Click Review + Create → Create(Deployment takes ~2–3 minutes)
4. Open the Databricks resource, Click Launch Workspace.

### Create Cluster

1. Go to Compute, Click Create cluster.
2. Configuration:
```
Cluster name: de-cluster
Databricks runtime: Latest LTS
Policy: unrestricted
Node type: Standard_DS3_v2
Single Node
```
3. Click Create

### Connect to ADLS Gen2

- Use Managed Identity or Service Principal

I will be using Access Connector for Azure Databricks, it's most secure way to handle storage access, especially if you are using Unity Catalog. Using the Access Connector allows for a "secretless" connection. Instead of managing Service Principal client secrets or storage account keys, you use a Managed Identity that Azure handles for you.

1. Go to your resource group, click on create and search for Access Connector for Azure Databricks.
2. Fill the basic details.
3. Once created, go to the Properties tab and copy the Resource ID.
4. Grant Permissions on the Storage Account.
    1. Go to your ADLS Gen2 Storage Account > Access Control (IAM).
    2. Click Add role assignment.
    3. Select the role Storage Blob Data Contributor.
    4. Under Assign access to, select Managed Identity, then select your Access Connector.
5. Create the Storage Credential in Databricks
    1. Open your Databricks workspace (must be Unity Catalog-enabled).
    2. Go to Catalog > External Data > Storage Credentials.
    3. Click Create credential, select Managed Identity, and paste the Resource ID you copied earlier.
6. Define an External Location
    1. In the same External Data section, go to External Locations.
    2. Create a new location that points to your container path (e.g., abfss://container@account.dfs.core.windows.net/).
    3. Select the Storage Credential you just created.