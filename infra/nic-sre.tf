resource "azurerm_network_interface" "sre" {
  name                = "srelab01314"
  resource_group_name = "RG-LAB-SRE"
  location            = "northcentralus"

  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    subnet_id                     = azurerm_subnet.sre_ad.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.sre.id
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_interface_security_group_association" "sre" {
  network_interface_id      = azurerm_network_interface.sre.id
  network_security_group_id = azurerm_network_security_group.sre.id
}
