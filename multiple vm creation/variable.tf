# Define VM configuration
variable "rg_name" {
  type = string
  default = "goldmedal"
}

variable "location" {
  type = string
  default = "east us"
}

variable "virtual_network_name" {
  type = string
  default = "gold-vnet"
}

variable "subnet_name" {
  type = string
  default = "gold_subnet"
}

variable "vm_size" {
  type = string
  default = "Standard_Bs1"
}

variable "os_disk_name" {
  type = string
  default = "gold_disk"
}

variable "image_name" {
  type = string
  default = "Microsoft_WindowsServer"
}


