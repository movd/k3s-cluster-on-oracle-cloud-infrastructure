variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "vcn_id" {
  description = "Created VCN"
  type        = string
}

variable "cluster_subnet_id" {
  description = "Subnet for the bastion instance"
  type        = string
}

variable "kuberntes_api_port" {
  description = "Kubernetes API Port"
  type        = number
  default     = 6443
}

variable "server_1_id" {
  description = "ID of Server 1"
  type        = string
}

variable "server_2_id" {
  description = "ID of Server 2"
  type        = string
}
