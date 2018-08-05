variable "client_id" {}
variable "client_secret" {}

provider "azurerm" {
}




#####
#
# Kubernetes
#
#####

module "aks" {
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  resource_group_name = "${azurerm_resource_group.k8stest.name}"
  location = "East US"
  ssh_public_key = "aks/locust.pub"
  source = "aks"
  agent_count = 3
  app_replica_count = 3
  app_container_image_url = "vignesh97/simple-webservice:latest"
}



module "locust" {
  source = "locust"
  id = "${module.aks.id}"
  kube_config = "${module.aks.kube_config}"
  client_key = "${module.aks.client_key}"
  client_certificate = "${module.aks.client_certificate}"
  cluster_ca_certificate = "${module.aks.cluster_ca_certificate}"
  host = "${module.aks.host}"
  app_endpoint = "http://${module.aks.load_balancer_ip}"
  master_count = "1"
  worker_count = "5"
  locust_container_image_url = "vignesh97/loadscript-locust:latest"
}

