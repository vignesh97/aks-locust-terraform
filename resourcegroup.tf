# Lookup Resource group


resource "azurerm_resource_group" "k8stest" {
  name = "k8stest"
  location = "East US"
}

