// Virtual Network
resource "azurerm_virtual_network" "main" {
    name                = "${var.project_name}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.group_name
}

// Public Subnet with NSG allowing SSH from everywhere
resource "azurerm_subnet" "public" {
    name                 = "external"
    resource_group_name  = var.group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_security_group" "public" {
  name                = "external-nsg"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "external"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

resource "azurerm_public_ip" "public" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = var.group_name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}
resource "azurerm_network_interface" "public" {
    name                = "${var.project_name}-pubnic"
    location            = var.location
    resource_group_name = var.group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.public.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public.id
    }
}

// Private Subnet with NSG allowing SSH only from public subnet
resource "azurerm_subnet" "private" {
    name                 = "internal"
    resource_group_name  = var.group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.3.0/24"]
}
resource "azurerm_network_security_group" "private" {
  name                = "internal-nsg"
  location            = var.location
  resource_group_name = var.group_name

  security_rule {
    name                       = "internal"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private.id
}


resource "azurerm_network_interface" "private" {
    name                = "${var.project_name}-privnic"
    location            = var.location
    resource_group_name = var.group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.private.id
        private_ip_address_allocation = "Dynamic"
    }
}