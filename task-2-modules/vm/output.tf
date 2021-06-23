// Output the VM IPs and admin user
output "public_ip" {
  value = azurerm_linux_virtual_machine.public.private_ip_address
}
output "private_ip" {
  value = azurerm_linux_virtual_machine.private.private_ip_address
}
output "admin_user" {
  value = azurerm_linux_virtual_machine.public.admin_username
}