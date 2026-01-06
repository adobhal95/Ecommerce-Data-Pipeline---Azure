### Steps

1. In the search bar, type Azure Key Vault, Click + Create.
2. Fill basic details:
    | Field          | Example           |
    | -------------- | ----------------- |
    | Subscription   | Your subscription |
    | Resource Group | de-project-rg     |
    | Key vault name | de-keyvault-001   |
    | Region         | Central India     |
    | Pricing tier   | Standard          |
    Click Next
3.  Choose Azure role-based access control (RBAC), Click Review + Create and then + Create.

### Grant Access to Services (Example: ADF Or User Account)

- Using RBAC

1. Key Vault → Access control (IAM)
2. Add role assignment
3. Role: Key Vault Secrets Officer/User. Give Key Vault Secrets User to ADF and Key Vault Secrets Officer to your account. 
4. Assign to: User Group Or Service Principal

**Assigning Role TO ADF**
1. Select the role Key Vault Secrets User then select service principal, then choose your subscription, for managed identity: data factory(v2) and then choose the adf you have created.



### Add Secrets

- Open Key Vault
    1. Go to Key Vault → Secrets
    2. Click + Generate/Import

- Add Secret
    1. Name: postgresqlpassword
    2. Value: mypassword123
    3. Click Create

Create secrets for username, password, dbname, etc for your on premise sql.