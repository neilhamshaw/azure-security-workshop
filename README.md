# Azure Foundation Security Workshop
This series of hands-on labs provides a method to learn some of the basics of securing your Microsoft Azure Cloud environment.

The workshop builds and uses an architecture which is a simplified version of the **[Microsoft Azure Reference Architecture](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/n-tier/n-tier-sql-server)** to deploy an **N-Tier application**, with various resources and tiers removed to simplify and speed up the process of deployment as per the following diagram.

<<Architecture Diagram>>

## Before you begin

This workshop gets you to hands-on with the Azure platform. To gain the maximum benefit from the labs, you **must** be able to log in to an Azure Subscription, against which you have the necessary access permissions to create, edit and delete resources.

**IMPORTANT:** Some of the labs **will** get you to create Azure resources which are chargeable against the Subscription they are built in. Whilst the costs are relatively low, the charges will persist whilst the resources remain active, so please take the following into consideration:

- If you are using a company Subscription, ensure that you have been given authority to create billable resources.
- If using an MSDN Subscription, keep a close watch on the costs and how they consume your monthly allowance.
- We would **not** recommend using a personal Subscription for these labs. Any costs charged to your personal credit/debit card are at the users discretion.

## Conventions and formatting
When navigating through the workshop, please pay close attention to the following conventions and formatting

```
Code examples, or command line output, will appear like this
```

Where chevrons are used in code examples, such as ```<resource-group-name>```, this dictates a value which must be amended or changed within the code before it is executed. Usually it will be a value of a resource or property which has been created by the you. For example, an instruction may give a command to show the properties of an Azure Resource Group, as follows:

```
az group show --resource-group <resource-group-name>
```

If a Resource Group had been created called **workshop-resource-group**, this is the actual command which must be entered:

```
az group show --resource-group workshop-resource-group
```

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
    
    - The **Subscription** field should default to your Subscription name. If not, set this to the required Azure Subscription.
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

    The ouput of this command will show details of your Azure account and active Subscription...

    ```
    [
      {
        "cloudName": "AzureCloud",
        "id": "a9283e63-30c3-4f95-u253-29a1d38bbc1c",
        "isDefault": true,
        "name": "Test Subscription",
        "state": "Enabled",
        "tenantId": "99389de2-36bb-4f5c-512c-d5edda836d1",
        "user": {
          "cloudShellID": true,
          "name": "myself@mycompany.org",
          "type": "user"
        }
      }
    ]
    ```

    **WORKSHOP TIP:** Copy and paste the **id** property from the output into a new Notepad window. This is the Subscription ID which will be used in some of the commands during the workshop labs.

### 5. Deploy the base architecture (time to complete: 10 to 15 min)
The resources to build the architecture shown above can be deployed via a script, known as a template. Azure Resource Manager (ARM) Templates are JSON formatted files which describe Azure Infrastructure as code, allowing for consistent and repeatable deployments.

Please refer to [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview#template-deployment](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview#template-deployment) for more further reading.

#### 5.1 Create the Resource Group

**VERY IMPORTANT: Use location 'WestEurope' to deploy your infrastructure for all labs. This will better guarantee that you will not have issues with the Azure Pass credits and availability of Virtual Machine types.**

Run the following command to create a Resource Group, providing your own Resource Group name for the **--name** parameter. This Resource Group will be used throughout the workshop and is a container inside which all Azure resources will be created. When considering a name for the Resource Group, make it something useful such as **workshop-resources**, **my-resource-group** or similar. 

Parameters:

- **--location**: westeurope
- **--name**: your own Resource Group name

```
az group create --location <location> --name <resource-group-name>
```

The output from the command will appear similar to this...

```
{
  "id": "/subscriptions/a9283e63-30c3-4f95-u253-29a1d38bbc1c/resourceGroups/my-resource-group",
  "location": "westeurope",
  "managedBy": null,
  "name": "my-resource-group",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": null
}
```

#### 5.2 Deploy the template into the Resource Group

The template for the initial deployment is the [security-workshop-template.json](/templates/security-workshop-template.json) file, and can be deployed by running the command below, which creates a Resource Group deployment in the **West Europe** Azure region. **Please note:** the link to the file on the repository (as the value for the **template-uri** parameter) links to the 'raw' version of the template, which is a pure text version of the file without any GitHub formatting.

Parameters:

- **--resource-group**: the name of the Resource Group created above

```
az group deployment create --resource-group <resource-group-name> --name Lab-Deployment --template-uri https://raw.githubusercontent.com/neilhamshaw/azure-security-workshop/master/templates/security-workshop-template.json  --parameters '{"location": { "value": "westeurope" } }'
```

The deployment typically takes around 15 minutes to complete.

#### 5.3 Checking the progress of a deployment
Deployment progress can be checked from the Azure Portal using the following steps...

- Click on **Resource Groups** on the favourites bar

  ![RGMenuOption](images/homepage/RGMenuOption.png)

- Click the Resource Group created previously to bring up the properties pane for the Resource Group. **Note** that this also displays all resources within the Resource Group and once the deployment has completed, will be fully populated with the initial lab resources (similar to the following image)...

  ![RGResources](images/homepage/RGResources.png)

- Under the **Settings** heading, click **Deployments**.

  ![RGDeployments](images/homepage/RGDeployments.png)

  This screen highlights the deployments running (or which have been previously deployed) against the Resource Group, and clicking the **Lab-Deployment** entry (click on the name itself) will show further information about the deployment, such as the resources created and the current status of each element.

  ![RGDeploymentDetails](images/homepage/RGDeploymentDetails.png)

Once deployed, [proceed to the workshop labs](/labs/README.md).

Some notes about the template:
- Parameter defaults