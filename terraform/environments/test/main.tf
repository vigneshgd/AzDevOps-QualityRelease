terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.50"
    }
  }
}

provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "tstatestact01"
    container_name       = "tstate-container"
    key                  = "S3Vk3sCUD0qnebqe7wUAyDJuHxKmmEm2juoOufjly6MR8boVg5tpUIV5icE7GFnOqCuKbEOVstMWZeOubV6hWw=="
    access_key           = "S3Vk3sCUD0qnebqe7wUAyDJuHxKmmEm2juoOufjly6MR8boVg5tpUIV5icE7GFnOqCuKbEOVstMWZeOubV6hWw=="
  }
}

module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
  application_type     = "${var.application_type}"
  tier              = "${var.tier}"
  deployment        = "${var.deployment}"
}

module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
  tier                 = "${var.tier}"
  deployment           = "${var.deployment}"
}

module "nsg" {
  source           = "../../modules/nsg"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
  tier              = "${var.tier}"
  deployment        = "${var.deployment}"
}

module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
  tier              = "${var.tier}"
  deployment        = "${var.deployment}"
  sku_tier          = "${var.sku_tier}"
  sku_size          = "${var.sku_size}"
}


module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${module.resource_group.resource_group_name}"
  tier              = "${var.tier}"
  deployment        = "${var.deployment}"  
}

module "vm" {
  source           = "../../modules/vm"
  resource_group   = "${module.resource_group.resource_group_name}"  
  tier              = "${var.tier}"
  deployment        = "${var.deployment}"
  resource_type     = "VM"
  vm_size           = "${var.vm_size}"
  admin_user        = "${var.admin_user}"
  vm_ssh_key        = "${var.vm_ssh_key}"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  subnet_id        = "${module.network.subnet_id_test}"
  public_ip_address_id = module.publicip.public_ip_address_id 
}