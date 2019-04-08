# Azure Foundation Security Workshop
This series of hands-on labs provides a method to learn some of the basics of securing your Microsoft Azure Cloud environment.

The architecture is a simplified version of the **[Microsoft Azure Reference Architecture](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/n-tier/n-tier-sql-server)** to deploy an **N-Tier application**, with various resources and tiers removed to simplify and speed up the process of deployment as per the following diagram.

<<Architecture Diagram>>

## Before you begin

This workshop gets you to hands-on with the Azure platform. To gain the maximum benefit from the labs, you should be able to log in to an Azure Subscription, inside which you have the access permissions to create resources.

**IMPORTANT:** Some of the labs **will** create Azure resources which are chargeable against the Subscription you build them in. Whilst the costs are relatively low, the charges will persist whilst the resources remain active, so please take the following into consideration:

- If you are using a company Subscription, ensure that you have been given authority to create billable resources.
- If using an MSDN Subscription, keep a close watch on the costs and how they consume your monthly allowance.
- We would **not** recommend using a personal Subscription for these labs. Any costs charged to your personal credit/debit card are at the users discretion.

## Getting set up

### 1. Create a new Microsoft Account
For the purposes of the workshop, it is advisable to create a brand new Microsoft Account which you will use to log in to the Azure Portal. Having a new account ensures a brand new out-of-the-box experience which is dedicated to these labs.

Please follow the instructions on the setup page to create the Microsoft Account.

**Please note:** If you prefer to use an existing Hotmail, Gmail or other address, this step can be skipped. However you may find that applying the Azure Pass Credits in section 2 below will not work if the account has been used to log in to the Azure Portal on a previous occasion.

### 2. Redeem your Azure Pass and activate the credit

If you are setting up an Azure Pass or creating a Microsoft Account for the purposes of this lab, please visit the [Account Creation](/instructions/CreateAccount.md) page.

### 3. Log in to the Azure Portal

The Azure Pass setup should take you to the Azure Portal but if it does not, open a new browser window and navigate to the Azure Portal address, https://portal.azure.com. Login with your new account credentials.

### 4. Configure Azure Cloud Shell

The labs use a combination of Azure CLI and Powershell commands which can be run directly in the Azure Portal using the Azure Cloud Shell.

To configure Cloud Shell

- On the Azure Portal, click the **Cloud Shell** link on the very top bar of the portal screen. The Cloud Shell window will open in the bottom half of the screen.

<image>

- At the **Welcome to Azure Cloud Shell** screen, click **Bash**

<image>

- The system will tell you that you have no storage configured. Click the **Show advanced settings** link.
- To configure the storage on the Advanced Settings page:
    
    - The **Subscription** field should default to your Subscription name. If not, set theis to the required Azure Subscription.
    - Set the **Cloud Shell region** to **West Europe**
    - Under **Resource Group**, ensure **Create New** is selected and enter a name for a new Azure Resource Group, which will be a container for the new Storage Account. This can be anything you choose.
    - Set **Storage Account** to **Create New** and enter the name for the Storage Account. **Please note** that Storage Account names must be between 3 and 24 characters long, and contain numbers and lower-case letters only).
    - Create a new **File Share**, again with the name of your choice.
    - Click **Create Storage**. The system will provision your storage account for the Cloud Shell and attempt to create a new shell session.

<image for this required>

- Test your new shell by running the following command to list Resource Groups in your Azure Subscription.

    ```
    az account list
    ```

    The ouput of this command will show details of your Azure account and active Subscription.

    **WORKSHOP TIP:** Copy and paste the **id** property into a new Notepad window. This is the Subscription ID which will be used in some of the command during the labs.

### 5. Deploy the base architecture

az group deployment create --resource-group azure-security-workshop --name JB-Deployment --template-file security-workshop-jb.json --parameters '{"location": { "value": "uksouth" } }'

az group deployment create --resource-group azure-security-workshop --name Lab-Deployment --template-file security-workshop-template.json

Some notes about the template:
- Parameter defaults
