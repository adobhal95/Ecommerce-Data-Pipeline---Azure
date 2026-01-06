### Steps

1. In your resource group search for Logic App. Click Create.
2. Plan Type: Select Consumption (this is the most cost-effective for simple alerts).
3. Basics Tab:
    1. Subscription/Resource Group: Select your existing ones.
    2. Logic App Name: e.g., adf-email-notifier.
    3. Region: Choose the same region as your Data Factory.
4. Click Review + Create, then click Create.

### Design the Workflow

Once the deployment is complete, go to the resource. You will see the Logic App Designer.

1. Select a Trigger: Scroll down and select the "When a HTTP request is received" card.
2. Click Use sample payload to generate schema.
3. Paste this JSON so the Logic App knows what data to expect from ADF:
    ```
    {
    "type": "object",
    "properties": {
        "pipelineName": { "type": "string" },
        "status": { "type": "string" },
        "runId": { "type": "string" },
        "time": { "type": "string" }
    }
}
    ```
4. Add an Action: Click + New step.
5. Search for gmail and select the action "Send an email (V2)".
6. Sign in: You will need to log in to your gmail account to authorize it.
7. Configure Fields.