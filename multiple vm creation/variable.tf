# Define VM configuration
variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "os_disk_name" {
  type = string
}

variable "image_name" {
  type = string
}

# Define variable for number of VMs
variable "num_vms" {
  type = number
}
