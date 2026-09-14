resource "azurerm_network_interface" "sccm" {
  name                = "sccm01646"
  resource_group_name = azurerm_resource_group.windows.name
  location            = "eastus"

  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    subnet_id                     = azurerm_subnet.client.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.windows["sccm"].id
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_interface_security_group_association" "sccm" {
  network_interface_id      = azurerm_network_interface.sccm.id
  network_security_group_id = azurerm_network_security_group.windows["sccm"].id
}
