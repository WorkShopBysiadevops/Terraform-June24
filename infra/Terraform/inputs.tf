variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "location"
  default     = "Central India"
}

variable "aks_info" {
  type = object({
    node_pool_name = string
    node_count     = number
    vm_size        = string
  })
  description = "node pool configuration"

}

variable "build_number" {
    type = string
    default = "0"
  
}
