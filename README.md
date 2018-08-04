
Distributed Load Testing with Locust in Azure Kubernetes Service(AKS)



az login
az account show --query "{subscriptionId:id, tenantId:tenantId}"
az account set --subscription="{subscriptionId}"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/{subscriptionId}"

export ARM_SUBSCRIPTION_ID=your_subscription_id
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=your_tenant_id

# Not needed for public, required for usgovernment, german, china
export ARM_ENVIRONMENT=public
export TF_VAR_client_id=${ARM_CLIENT_ID}
export TF_VAR_client_secret=${ARM_CLIENT_SECRET}

terraform init
terraform plan
terraform apply