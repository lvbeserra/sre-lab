resource "azurerm_virtual_network" "sccm" {
  name                = "vnet-sccm-eastus"
  resource_group_name = "RG-LAB-WIN2025"
  location            = "eastus"
  address_space       = ["10.0.0.0/16", "172.17.0.0/16"]
  dns_servers         = ["172.16.0.5"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "client" {
  name                 = "default"
  resource_group_name  = "RG-LAB-WIN2025"
  virtual_network_name = azurerm_virtual_network.sccm.name
  address_prefixes     = ["10.0.0.0/24"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "sccm" {
  name                 = "snet-sccm"
  resource_group_name  = "RG-LAB-WIN2025"
  virtual_network_name = azurerm_virtual_network.sccm.name
  address_prefixes     = ["172.17.0.0/24"]

  lifecycle {
    prevent_destroy = true
  }
}
