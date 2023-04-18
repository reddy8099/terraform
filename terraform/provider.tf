terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

subscription_id = "58946ec8-0f9a-463e-a88c-cd43b82daeaa"
Client_id = "05c70ba8-7db9-4ece-a4b8-98f2d9cd1f96"
Client_secret = "EFV8Q~AyV1ihNrVsmH7iGHoYhaUhXTJpm9-A9cFQ"
Tenant _id = "b2b05694-7ebc-412e-ad4e-8c2282741c96"

}