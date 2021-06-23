// Output the subnet IDs for the VMs
output "interface_id_public" {
    value = azurerm_network_interface.public.id
}

output "interface_id_private" {
    value = azurerm_network_interface.private.id
}

output "subnet_public_id" {
  value = azurerm_subnet.public.id
}

output "subnet_private_id" {
  value = azurerm_subnet.private.id
}