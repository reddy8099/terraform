variable "resource_group_name"{
    type = string
    description = "RG name in Azure"

}

variable "location" {
    type = string
    description = "Resource loacion in Azure"

}
variable "cluster_name" {
    type = string
    description = "AKS name in Azure"

}
variable "kubernetes_version" {
    type = string
    description = "kubernetes version"

}
variable "system_node_count" {
    type = string
    description = "number of AKS worker nodes"

}
variable "acr_name" {
    type = string
    description = "acr name"

}