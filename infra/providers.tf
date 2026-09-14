terraform {
  required_version = ">= 1.5, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id                 = "2237e4b1-cccb-4531-a1ed-acec25f43639"
  resource_provider_registrations = "none"
}
