# Azure GUIDS
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Resource Group/Location
variable "location" {}
variable "resource_group" {}
variable "application_type" {}
variable "sku_size" {}
variable "sku_tier" {}

# Tags
variable tier {}
variable deployment {}

# Network
variable virtual_network_name {}
variable address_prefix_test {}
variable address_space {}
#variable subnet_id_test {}

#VM
variable "vm_size" {}
variable "admin_user" {}
variable "admin_pass" {}
variable "vm_ssh_key" {}