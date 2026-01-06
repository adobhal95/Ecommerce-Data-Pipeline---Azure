### Steps

1. Search Storage accounts. Click + Create
2. Basic Settings
    |Field|	Example|
    |--|--|
    |Subscription|	Your subscription|
    |Resource Group|	de-project-rg|
    |Storage account| name	delakehouse001|
    |Region	Central| India|
    |Performance|	Standard|
    |Redundancy|	LRS|
3. Click Next : Advanced
4. Enable Hierarchical Namespace: Toggle Hierarchical namespace → Enabled (This converts Blob Storage into ADLS Gen2)
5. Click Review + Create, then Create.

### Create Continers

1. Open the storage account → Containers → + Container
2. Create:
    = bronze
    - silver
    - gold

**Access Control**

Two options, first is to give access at account level, or second is to give at container level.

1. Option 1: RBAC (Account level)
    - IAM → Add role assignment
    - Role: Storage Blob Data Contributor

2. Option 2: ACLs (Folder level)
    - Containers → Access Control (ACL)
    - Grant read/write/execute permissions

- Role will be given to adf to write data into bronze container.

    **Assigning Role TO ADF**:

    Select the role Storage Blob Data Contributor then select service principal, then choose your subscription, for managed identity: data factory(v2) and then choose the adf you have created.

- Role will be given to databricks to read data from bronze and write into silver layer.

- Role will be given to synapse to read data from gold layer.