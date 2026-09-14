locals {
  peerings = {
    sre_to_ad = {
      name   = "sre-para-ad"
      group  = "RG-LAB-SRE"
      source = azurerm_virtual_network.sre.name
      target = azurerm_virtual_network.ad.id
    }
    ad_to_sre = {
      name   = "ad-para-sre"
      group  = "RG-LAB-WIN2025"
      source = azurerm_virtual_network.ad.name
      target = azurerm_virtual_network.sre.id
    }
    sccm_to_ad = {
      name   = "northcentralus-to-eastus"
      group  = "RG-LAB-WIN2025"
      source = azurerm_virtual_network.sccm.name
      target = azurerm_virtual_network.ad.id
    }
    ad_to_sccm = {
      name   = "eastus-to-northcentralus"
      group  = "RG-LAB-WIN2025"
      source = azurerm_virtual_network.ad.name
      target = azurerm_virtual_network.sccm.id
    }
  }
}

resource "azurerm_virtual_network_peering" "lab" {
  for_each = local.peerings

  name                      = each.value.name
  resource_group_name       = each.value.group
  virtual_network_name      = each.value.source
  remote_virtual_network_id = each.value.target

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  lifecycle {
    prevent_destroy = true
  }
}
