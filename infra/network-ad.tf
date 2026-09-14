resource "azurerm_virtual_network" "ad" {
  name                = "vnet-northcentralus-1"
  resource_group_name = azurerm_resource_group.windows.name
  location            = "northcentralus"
  address_space       = ["172.16.0.0/16"]
  dns_servers         = ["172.16.0.5"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "ad" {
  name                 = "snet-northcentralus-1"
  resource_group_name  = azurerm_resource_group.windows.name
  virtual_network_name = azurerm_virtual_network.ad.name
  address_prefixes     = ["172.16.0.0/24"]

  lifecycle {
    prevent_destroy = true
  }
}
