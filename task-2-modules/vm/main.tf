// Public VM
resource "azurerm_linux_virtual_machine" "public" {
    name                  = "${var.project_name}-pubvm"
    resource_group_name   = var.group_name
    location              = var.location
    size                  = var.vm_size
    network_interface_ids = [var.interface_ids["public"]]

    admin_username = "adminuser"
    admin_password = "LetMeIn!"

    disable_password_authentication = false

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = var.storage_size
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }    
}

// Private VM
resource "azurerm_linux_virtual_machine" "private" {
    name                  = "${var.project_name}-privvm"
    resource_group_name   = var.group_name
    location              = var.location
    size                  = var.vm_size
    network_interface_ids = [var.interface_ids["private"]]

    admin_username = "adminuser"
    admin_password = "LetMeIn!"

    disable_password_authentication = false

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = var.storage_size
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }    
}
