
locals {
  identifier = "dev-hub-spoke"
  subnets = [
    {
      name = "firewall-subnet"
      }, {
      name = "public-subnet"
      type = "public"
    }
  ]
}

resource "azurerm_resource_group" "this" {
  name             = lower("rg-${local.identifier}")
  location         = var.location
}

module "network" {
  source              = "github.com/fractiuante-az/tf-modules?ref=main//terraform/modules/network"
  # source              = "../../../../tf-modules/terraform/modules/network" # Local Speed Up Development 😉
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  vnet_cidr           = "11.0.0.0/16"
  identifier          = local.identifier
  subnets             = local.subnets

}
