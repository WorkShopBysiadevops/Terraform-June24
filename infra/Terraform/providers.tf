terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.106.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backend"
    storage_account_name = "ltbackendworkshop"
    container_name       = "state"
    key                  = "workshop.tfstate"

  }
}

provider "azurerm" {
  features {

  }
}