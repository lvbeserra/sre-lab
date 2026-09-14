resource "azurerm_network_interface" "client" {
  name                           = "client0114"
  resource_group_name            = azurerm_resource_group.windows.name
  location                       = "eastus"
  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    subnet_id                     = azurerm_subnet.client.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.windows["client"].id
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_interface_security_group_association" "client" {
  network_interface_id      = azurerm_network_interface.client.id
  network_security_group_id = azurerm_network_security_group.windows["client"].id
}
