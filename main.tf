resource "azurerm_resource_group" "rg1" {
  name     = "resource_group1"
  location = "East US"
}

module "vm1" {
    source = "./modules/vm"
    subnet_id = azurerm_subnet.vnet01_subnet0.id
    rg_name = azurerm_resource_group.rg1.name
    nsg = azurerm_network_security_group.lb_vms_nsg.id
    vm_name = "testvm"
  }

module "vm2" {
    source = "./modules/vm"
    subnet_id = azurerm_subnet.vnet01_subnet0.id
    rg_name = azurerm_resource_group.rg1.name
    nsg = azurerm_network_security_group.lb_vms_nsg.id
    vm_name = "test2vm"
  }

