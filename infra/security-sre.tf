resource "azurerm_network_security_group" "sre" {
  name                = "SRELAB01-nsg"
  resource_group_name = "RG-LAB-SRE"
  location            = "northcentralus"

  security_rule {
    name                       = "Allow-SSH-MeuIP"
    description                = "SSH apenas do meu IP público"
    priority                   = 311
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "172.174.233.14/32"
    destination_address_prefix = "*"
  }

  lifecycle {
    prevent_destroy = true
  }
}
