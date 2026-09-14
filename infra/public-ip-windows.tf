locals {
  windows_public_ips = {
    client = {
      name     = "CLIENT01-ip"
      location = "eastus"
      zones    = ["1"]
    }
    sccm = {
      name     = "SCCM01-ip"
      location = "eastus"
      zones    = null
    }
    ad = {
      name     = "DC01-ip"
      location = "northcentralus"
      zones    = null
    }
  }
}

resource "azurerm_public_ip" "windows" {
  for_each = local.windows_public_ips

  name                    = each.value.name
  resource_group_name     = azurerm_resource_group.windows.name
  location                = each.value.location
  zones                   = each.value.zones
  allocation_method       = "Static"
  sku                     = "Standard"
  sku_tier                = "Regional"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4

  lifecycle {
    prevent_destroy = true
  }
}
