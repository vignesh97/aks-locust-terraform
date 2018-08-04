output load_balancer_ip {
  value = "${kubernetes_service.app-service.load_balancer_ingress.0.ip}"
}

