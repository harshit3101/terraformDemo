# Virtual network variables

variable "subnets_map" {
  type        = map(string)
  description = "Subnet name to address_prefixes mapping. Default is empty."
  default     = {}
}

/*usage: 

  subnets_map                = {
    example_subnet_name  = "10.1.0.0/24"
  }
*/

variable "vnet_name" {
  type        = string
  description = "Name of Virutal network."
}

variable "rg_name" {
  type        = string
  description = "Name of Resource group."
}

