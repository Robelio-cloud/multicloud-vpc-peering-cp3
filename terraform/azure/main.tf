resource "azurerm_resource_group" "rg_cp3_criado_pelo_terraform" {
  name     = "rg-cp3-criado-pelo-terraform"
  location = "Brazil South"
}

# VNET 1
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_cp3_robelio.location
  resource_group_name = azurerm_resource_group.rg_cp3_robelio.name
}

# VNET 2
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  address_space       = ["20.0.0.0/16"]
  location            = azurerm_resource_group.rg_cp3_robelio.location
  resource_group_name = azurerm_resource_group.rg_cp3_robelio.name
}

# VNET Peering
resource "azurerm_virtual_network_peering" "vnet_peering" {
  name                      = "vnet1-to-vnet2"
  resource_group_name       = azurerm_resource_group.rg_cp3_robelio.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}

resource "azurerm_virtual_network_peering" "vnet_peering_reverse" {
  name                      = "vnet2-to-vnet1"
  resource_group_name       = azurerm_resource_group.rg_cp3_robelio.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
