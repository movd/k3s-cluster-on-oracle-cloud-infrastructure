output "ad" {
  value = data.oci_identity_availability_domain.ad_2.name
}

output "cluster_token" {
  value = random_string.cluster_token.result
}

output "server_1_id" {
  value = oci_core_instance.server_1.id
}

output "server_2_id" {
  value = oci_core_instance.server_2.id
}
