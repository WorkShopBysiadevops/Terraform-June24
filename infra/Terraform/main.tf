# create a resource group
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Environment = terraform.workspace
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "workshop-${terraform.workspace}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "lt${terraform.workspace}"
  default_node_pool {
    name       = var.aks_info.node_pool_name
    node_count = var.aks_info.node_count
    vm_size    = var.aks_info.vm_size
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = terraform.workspace
    CreatedBy   = "Terraform"
  }

}

resource "null_resource" "connection" {
    triggers = {
      build_number = var.build_number
    }
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.this.name} --name ${azurerm_kubernetes_cluster.this.name}"
  }

}