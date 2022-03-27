output "loadbalancer_ips" {
  value = oci_network_load_balancer_network_load_balancer.kubernetes_load_balancer.ip_addresses
}
