terraform {
  backend "azurerm" {
    resource_group_name  = "RG-LAB-TFSTATE"
    storage_account_name = "stluizlabtf2237e4b1"
    container_name       = "tfstate"
    key                  = "sre-lab.tfstate"
    use_azuread_auth     = true
    use_cli              = true
  }
}
