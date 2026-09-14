resource "azurerm_virtual_network" "sre" {
  name                = "vnet-northcentralus-2"
  resource_group_name = "RG-LAB-SRE"
  location            = "northcentralus"
  address_space       = ["10.20.0.0/16"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "sre_ad" {
  name                            = "snet-sre-ad"
  resource_group_name             = "RG-LAB-SRE"
  virtual_network_name            = azurerm_virtual_network.sre.name
  address_prefixes                = ["10.20.0.0/24"]
  default_outbound_access_enabled = false

  lifecycle {
    prevent_destroy = true
  }
}
