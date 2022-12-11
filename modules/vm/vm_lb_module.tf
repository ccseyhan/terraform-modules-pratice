resource "azurerm_network_interface" "vm0_nic" {
  name                 = "${var.vm_name}-nic"
  location             = var.location
  resource_group_name  = var.rg_name
  enable_ip_forwarding = true


  ip_configuration {
    name                          = "vm0_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    # load_balancer_backend_address_pools_ids = azurerm_network_interface_backend_address_pool_association.vm0_lb_config.id
    
  }
}
resource "azurerm_network_interface_security_group_association" "vm0_nsg_config" {
  network_interface_id      = azurerm_network_interface.vm0_nic.id
  network_security_group_id = var.nsg
}
resource "azurerm_windows_virtual_machine" "vm0" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.vm0_username
  admin_password      = var.vm0_password
  network_interface_ids = [
    azurerm_network_interface.vm0_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
