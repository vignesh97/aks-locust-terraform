terraform {
  backend "azurerm" {
    storage_account_name = "loadtestk8s"
    container_name = "terraform"
    key = "prod.terraform.tfstate"
    resource_group_name = "k8stest"
    access_key=""
  }
}