variable id {
  default = ""
}
variable kube_config {
  default = ""
}
variable client_key {
  default = ""
}
variable client_certificate {
  default = ""
}
variable cluster_ca_certificate {
  default = ""
}
variable host {
  default = ""
}

variable app_endpoint {
  default = ""
}
variable master_count {
  default = 1
}
variable worker_count {
  default = 1
}

variable locust_container_image_url {
  default = "vignesh97/loadscript-locust:latest"
}
