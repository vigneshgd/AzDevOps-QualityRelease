resource "azurerm_virtual_network" "test" {
  name                 = "${var.application_type}-${var.resource_type}-net"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group}"
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }
}
resource "azurerm_subnet" "test" {
  name                 = "${var.application_type}-${var.resource_type}-subnet"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefixes       = "${var.address_prefix_test}"
}