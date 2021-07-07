resource "azurerm_network_interface" "test" {
  name                 = "${var.application_type}-nic"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }  
}

resource "azurerm_linux_virtual_machine" "test" {
  name                 = "${var.application_type}-VM"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group}"
  size                 = "${var.vm_size}"
  admin_username       = "${var.admin_user}"
  admin_password       = "${var.admin_pass}"
  disable_password_authentication = "true"
  network_interface_ids = [
    azurerm_network_interface.test.id,
    ]
  admin_ssh_key {
    username       = "${var.admin_user}"
    public_key = file("/home/vsts/work/_temp/udacity_azure.pub")
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }  
}