#data "azurerm_resource_group" "k8s" {
#  name     = "${var.resource_group_name}"
#  location = "${var.location}"
#}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.dns_prefix}"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${file("${var.ssh_public_key}")}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = "${var.agent_count}"
    vm_size         = "Standard_DS1"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  tags {
    Environment = "Production"
  }
}

output "id" {
    value = "${azurerm_kubernetes_cluster.k8s.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.host}"
}

provider "kubernetes" {
  host                   = "${azurerm_kubernetes_cluster.k8s.kube_config.0.host}"
 # username               = "${azurerm_kubernetes_cluster.k8s.kube_config.0.username}"
 # password               = "${azurerm_kubernetes_cluster.k8s.kube_config.0.password}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)}"
}

resource "kubernetes_replication_controller" "simple-webservice" {
  metadata {
    name = "simple-webservice"
    labels {
      name = "app"
      role = "webservice"
    }
  }

  spec {
    selector {
      name = "app"
      role = "webservice"
    }
    replicas = "${var.app_replica_count}"
    template {
      container {
        image = "${var.app_container_image_url}"
        name  = "locust"
        port {
          name = "simple-app-web"
          container_port = 80
          protocol = "TCP"
        }
      }
    }
  }
}

resource "kubernetes_service" "app-service" {
  metadata {
    name = "app-service"
    labels {
      name = "app"
      role = "webservice"
    }
  }
  spec {
    selector {
      name = "app"
      role = "webservice"
    }
    port {
      port = 80
      target_port = 80
      protocol = "TCP"
      name = "simple-app-web"
    }
    type = "LoadBalancer"
  }
}