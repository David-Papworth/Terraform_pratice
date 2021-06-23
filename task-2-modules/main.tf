// Terraform configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

// Provider
provider "azurerm" {
  features {}
}

// Resource Group
resource "azurerm_resource_group" "main" {
    name     = "${var.project_name}-rg"
    location = var.location
}

// Virtual Network module
module "virtual_network" {
  source       = "./vnet"
  project_name = var.project_name
  group_name   = azurerm_resource_group.main.name
  location     = var.location
}

// Virtual Machines module
module "virtual_machine" {
  source        = "./vm"
  project_name  = var.project_name
  group_name    = azurerm_resource_group.main.name
  location      = var.location
  interface_ids = {
    "private" = module.virtual_network.interface_id_private
    "public" = module.virtual_network.interface_id_public
    }
}
