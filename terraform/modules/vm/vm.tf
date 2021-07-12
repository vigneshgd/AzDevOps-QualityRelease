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
  name                 = "${var.application_type}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group}"
  size                 = "${var.vm_size}"
  admin_username       = "${var.admin_user}"

  disable_password_authentication = "true"
  network_interface_ids = [
    azurerm_network_interface.test.id,
    ]
  admin_ssh_key {
    username       = "${var.admin_user}"
    public_key = file("/home/vsts/work/_temp/udacity_azure.pub")
#    public_key = "qualityrelease AAAAB3NzaC1yc2EAAAABIwAAAQEArIood27UiDWIquKG6eT/vaMeCdVdcIEnzFn9UAMCd9RRQrESQKXSpMhpJWA9KDOOlHKG2R/uqDqv2z4hxRy3vCyTj+J9EnWnoFvPkiQijCQ4K+KcF9dEL7EP4WQD9H5eYGl0HyoKx6vzSBt3ZQydWOOfTdCGQueSpjp2b+hpFZvg6D54EVtCXzdQhkMTL30ehPZjdCwu6M2dzOILGJpfathb4S1DzTVaerujm3uPTCtfchOkQJb4TUFbraU56vb9fzs7HHh2hWOCvrkgRAkBiqO2BwdS+vRvfxN9l3u1j99n3gBrxDkDqJ32FZ7iTif77sA1c57j2dnIs3LUS3U6kw== qualityrelease"
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