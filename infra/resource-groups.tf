resource "azurerm_resource_group" "sre" {
  name     = "RG-LAB-SRE"
  location = "northcentralus"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_resource_group" "windows" {
  name     = "RG-LAB-WIN2025"
  location = "northcentralus"

  lifecycle {
    prevent_destroy = true
  }
}
