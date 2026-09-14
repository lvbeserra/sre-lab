resource "azurerm_network_interface" "ad" {
  name                = "dc01573"
  resource_group_name = "RG-LAB-WIN2025"
  location            = "northcentralus"

  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    subnet_id                     = azurerm_subnet.ad.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "172.16.0.5"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.windows["ad"].id
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_interface_security_group_association" "ad" {
  network_interface_id      = azurerm_network_interface.ad.id
  network_security_group_id = azurerm_network_security_group.windows["ad"].id
}
