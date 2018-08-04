variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
  default = 3
}
variable "app_replica_count" {
  default = 3
}

variable "app_container_image_url"{
  default = "vignesh97/simple-webservice:latest"
}

variable "ssh_public_key" {
  default = "locust.pub"
}

variable "dns_prefix" {
  default = "k8stest"
}

variable cluster_name {
  default = "k8stest"
}

variable resource_group_name {
  default = "k8stest"
}

variable location {
  default = "Central US"
}
