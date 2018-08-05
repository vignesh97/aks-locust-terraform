provider "kubernetes" {
  host                   = "${var.host}"
 # username               = "${azurerm_kubernetes_cluster.k8s.kube_config.0.username}"
 # password               = "${azurerm_kubernetes_cluster.k8s.kube_config.0.password}"
  client_certificate     = "${base64decode(var.client_certificate)}"
  client_key             = "${base64decode(var.client_key)}"
  cluster_ca_certificate = "${base64decode(var.cluster_ca_certificate)}"
}



resource "kubernetes_replication_controller" "locust-master" {
  metadata {
    name = "locust-master"
    labels {
      name = "locust"
      role = "master"
    }
  }

  spec {
    selector {
      name = "locust"
      role = "master"
    }
    replicas = "${var.master_count}"
    template {
      container {
        image = "${var.locust_container_image_url}"
        name  = "locust"
        port {
          name = "loc-master-web"
          container_port = 8089
          protocol = "TCP"
        }
        port {
          name = "loc-master-p1"
          container_port = 5557
          protocol = "TCP"
        }
        port {
          name = "loc-master-p2"
          container_port = 5558
          protocol = "TCP"
        }
        env {
          name = "LOCUST_MODE"
          value = "master"
        }
        env {
          name = "TARGET_HOST"
          value = "${var.app_endpoint}"
        }
      }
    }
  }
}

resource "kubernetes_service" "master-service" {
  metadata {
    name = "locust-master"
    labels {
      name = "locust"
      role = "master"
    }
  }
  spec {
    selector {
      name = "locust"
      role = "master"
    }
    port {
      port = 8089
      target_port = 8089
      protocol = "TCP"
      name = "loc-master-web"
    }
    port {
      port = 5557
      target_port = 5557
      protocol = "TCP"
      name = "loc-master-p1"
    }
    port {
      port = 5558
      target_port = 5558
      protocol = "TCP"
      name = "loc-master-p2"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_replication_controller" "locust-worker" {
  metadata {
    name = "locust-worker"
    labels {
      name = "locust"
      role = "worker"
    }
  }

  spec {
    selector {
      name = "locust"
      role = "worker"
    }
    replicas = "${var.worker_count}"
    template {
      container {
        image = "${var.locust_container_image_url}"
        name  = "locust"
        port {
          name = "loc-master-web"
          container_port = 8089
          protocol = "TCP"
        }
        port {
          name = "loc-master-p1"
          container_port = 5557
          protocol = "TCP"
        }
        port {
          name = "loc-master-p2"
          container_port = 5558
          protocol = "TCP"
        }
        env {
          name = "LOCUST_MODE"
          value = "worker"
        }
        env {
          name = "LOCUST_MASTER"
          value = "locust-master"
        }
        env {
          name = "TARGET_HOST"
          value = "${var.app_endpoint}}"
        }
      }
    }
  }
}