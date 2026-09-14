locals {
  windows_nsgs = {
    client = { name = "CLIENT01-nsg", location = "eastus" }
    sccm   = { name = "SCCM01-nsg", location = "eastus" }
    ad     = { name = "DC01-nsg", location = "northcentralus" }
    legacy = { name = "WIN2025LAB-nsg", location = "northcentralus" }
  }
}

resource "azurerm_network_security_group" "windows" {
  for_each = local.windows_nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = "RG-LAB-WIN2025"

  security_rule {
    name                       = "RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "189.55.152.102"
    destination_address_prefix = "*"
  }

  lifecycle {
    prevent_destroy = true
  }
}
