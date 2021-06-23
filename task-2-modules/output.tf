// Outputs that you want to display after you run terraform apply
// Public IP Output
output "public_ip" {
  value = module.virtual_machine.public_ip
}

// Private IP Output
output "private_ip" {
  value = module.virtual_machine.private_ip
}

// Admin User Output
output "admin_user" {
  value = module.virtual_machine.admin_user
}