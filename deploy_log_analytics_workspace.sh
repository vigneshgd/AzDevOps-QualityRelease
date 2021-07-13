#!/bin/bash
az deployment group create --resource-group qualityrelease --name deploy-log --template-file deploy_log_analytics_workspace.json