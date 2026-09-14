resource "azurerm_public_ip" "sre" {
  name                    = "SRELAB01-ip"
  resource_group_name     = azurerm_resource_group.sre.name
  location                = "northcentralus"
  allocation_method       = "Static"
  sku                     = "Standard"
  sku_tier                = "Regional"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4

  lifecycle {
    prevent_destroy = true
  }
}
