# AzDevOpsQualityRelease

Github work flow status:

[![Az Devops Ensuring Quality Release](https://github.com/vigneshgd/AzDevOps-QualityRelease/actions/workflows/terraform.yml/badge.svg)](https://github.com/vigneshgd/AzDevOps-QualityRelease/actions/workflows/terraform.yml)

Az Pipeline Build Status:

[![Build Status](https://dev.azure.com/petitguyin/TestWebAppProject/_apis/build/status/vigneshgd.AzDevOps-QualityRelease?branchName=main)](https://dev.azure.com/petitguyin/TestWebAppProject/_build/latest?definitionId=13&branchName=main)

# Udacity DevOps Engineer for Microsoft Azure Nanodegree Program <br/><br/> Final Project: Ensuring Quality Release

This project creates an automated CICD Pipeline using Microsoft Azure Devops platform. This project is a combination of Microsoft's IaaC, PaaS and SaaS products. This project implements:
  - A CICD Pipeline to provisions an cloud based virtualized infrastructue using terraform 
  - Packages and builds web service API called FakeAPI
  - Runs a collection of API Test cases using Postman tool
  - Deploys the FakeAPI Webservice on Azure App Service
  - Executes a set of WebGUI tests using Selenium
  - And finally performs a stress and endurance tests  against the deployed FakeAPI
  - Gives us some analytics based on the tests and logging that happening through each of the above stages of the pipeline

Every stage in the pipeline give us detailed summary, logs and results.

## Instructions

1. Create a new Project under your organization on Azure Devops portal. Next, create a Service Principal for current project using the command: 
    `az ad sp create-for-rbac --role="Contributor" --name="EnsuringQualityRelease"`
    
On Azure Devops portal -> Organization -> Project -> Project settings-> Service Connections -> Click on the newly created Service Connection -> Manage Service Principal. 
Obtain the values for then below parameters:

    subscription_id
    client_id
    client_secret
    tenant_id

   Add the values of the above parameters in: terraform/environments/test/terraform.tfvars

To keep these sensitive values secure, upload terraform.tfvars to:

    Pipeline --> Library --> Secure Files

![image](https://user-images.githubusercontent.com/52568208/125402728-beb94a80-e382-11eb-9bf6-613d4282edf4.png)

This file will be referenced in azure-pipelines.yaml

2. Create storage and backend account following the instructions in: [Configure the storage account and state backend.](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage)

3. Fill-in corresponding values for parameter `storage_account_name`, `container_name`, `key` and `access_key` in: terraform/environments/test/main.tf, azure-pipelines.yaml and all other terraform modules.
  
4. On your Azure Devops accoubt, [Install Terraform Azure Pipelines Extension by Microsoft DevLabs.](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)

5. Make sure all the terraform templates have these parameters set. 
6. Using powershell on your computer, navigate to terraform/environments/test/, where you will find `main.tf` which is the primary driving terraform template. On powershell, run `terraform init`. Make sure the directory is initialized without any errors. Next, run the command `terraform apply`. This command should setup the necessary infrastructure for the current CICD Pipeline execution. 

![image](https://user-images.githubusercontent.com/52568208/125404736-f628f680-e384-11eb-80b7-6e30f38d5b5a.png)

Make sure `terraform apply` command is successful without any errors. Next, delete the resources by running `terraform destroy` so that the infrastructure will be created using Az Pipeline.

7. Build FakeRestAPI artifact by archiving/packaging the fakerestapi directory into a zip file and publish the artifacts to the staging directory.

8. Deploy FakeRestAPI artifact to the terraform deployed Azure App Service. The deployed webapp URL is [https://qualityrelease.azurewebsites.net](https://qualityrelease.azurewebsites.net) where `qualityrelease` is the Azure App Service resource name.

    ![image](https://user-images.githubusercontent.com/52568208/125407181-a13aaf80-e387-11eb-8aa9-867deb64321c.png)


9. After creating VM in Azure Pipelines, we must register the VM in Pipelines --> Environments --> TEST --> Add resource --> Select "Virtual machines" --> Next --> In Operating system, select "Linux".

    ![image](https://user-images.githubusercontent.com/52568208/125407432-de06a680-e387-11eb-9130-9cc5258b1069.png)

10. [Create an Azure Log Analytics workspace.](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-create-workspace-cli)

    by executing `az deployment group create --resource-group qualityrelease --name HttpLogs --template-file deploy_log_analytics_workspace.json`.

11. [Install Log Analytics agent on Linux computers.](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/agent-linux)

    Follow the instructions to install the agent using the script: `wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w <YOUR WORKSPACE ID> -s <YOUR WORKSPACE PRIMARY KEY>` on the terraform deployed VM.
    
    Go to Settings --> Agents management under Log Analytics workspace to get Log Analytics Workspace ID and primary key and then set as secret variables for the pipeline.

    After setting up Log Analytics, you should see ""1 Linux computers connected"  under Settings --> Agents management.

    ![image](https://user-images.githubusercontent.com/52568208/125408493-f4613200-e388-11eb-8454-f5326a66d206.png)


12. Follow instruction [Collect custom logs with Log Analytics agent in Azure Monitor.](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-sources-custom-logs) to setup custom logs with Log Analytics.

    ![image](https://user-images.githubusercontent.com/52568208/125408853-5457d880-e389-11eb-965d-5ab0682bd6a5.png)

13. Verify Azure Monitor Logs collected from the Log Analytics agent installed on the deployed VM.

    ![image](https://user-images.githubusercontent.com/52568208/125409518-f8418400-e389-11eb-9efb-f065b5bd69d7.png)

14. Overall, you should see a successful pipeline run, various artifacts published during each stage of the pipeline run and status of test results during each stage. 

![image](https://user-images.githubusercontent.com/52568208/125409915-5ec6a200-e38a-11eb-8db6-24578a4b3dc9.png)

![image](https://user-images.githubusercontent.com/52568208/125409992-70a84500-e38a-11eb-937f-5f89008b0345.png)
