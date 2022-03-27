# Load Balancer for Kubernetes API

resource "oci_network_load_balancer_network_load_balancer" "kubernetes_load_balancer" {
  compartment_id             = var.compartment_id
  display_name               = "Kubernetes API Loadbalancer"
  subnet_id                  = var.cluster_subnet_id
  is_private                 = false
  network_security_group_ids = [oci_core_network_security_group.permit_kubernetes_api_lb.id]
}

resource "oci_network_load_balancer_listener" "kubernetes_api_listener" {
  default_backend_set_name = oci_network_load_balancer_backend_set.kubernetes_api_backend_set.name
  name                     = "Kubernetes API Listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kubernetes_load_balancer.id
  port                     = var.kuberntes_api_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "kubernetes_api_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.kuberntes_api_port
  }

  name                     = "Kubernetes API Backends"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kubernetes_load_balancer.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "kubernetes_api_backend_1" {
  backend_set_name         = oci_network_load_balancer_backend_set.kubernetes_api_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kubernetes_load_balancer.id
  port                     = var.kuberntes_api_port

  target_id = var.server_1_id
}

resource "oci_network_load_balancer_backend" "kubernetes_api_backend_2" {
  backend_set_name         = oci_network_load_balancer_backend_set.kubernetes_api_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kubernetes_load_balancer.id
  port                     = var.kuberntes_api_port

  target_id = var.server_2_id
}

resource "oci_core_network_security_group" "permit_kubernetes_api_lb" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "Permit Kubernetes API"
}

resource "oci_core_network_security_group_security_rule" "permit_kubernetes_api_lb" {
  network_security_group_id = oci_core_network_security_group.permit_kubernetes_api_lb.id
  protocol                  = "6" // TCP
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = var.kuberntes_api_port
      min = var.kuberntes_api_port
    }
  }
  direction = "INGRESS"
}
