variable "client_admin_password" {
  description = "Senha necessária apenas para criar ou reconstruir CLIENT01."
  type        = string
  sensitive   = true
  default     = null
}

resource "azurerm_windows_virtual_machine" "client" {
  name                = "CLIENT01"
  computer_name       = "CLIENT01"
  resource_group_name = "RG-LAB-WIN2025"
  location            = "eastus"
  size                = "Standard_D2as_v7"
  zone                = "1"
  admin_username      = "azureuser"
  admin_password      = var.client_admin_password

  network_interface_ids = [azurerm_network_interface.client.id]

  provision_vm_agent       = true
  automatic_updates_enabled = false
  patch_mode               = "Manual"
  patch_assessment_mode    = "ImageDefault"
  hotpatching_enabled      = false
  secure_boot_enabled      = true
  vtpm_enabled             = true

  os_disk {
    name                 = "CLIENT01_OsDisk_1_838f17a7bb2b44139489b251858fd53c"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 127
  }

  source_image_reference {
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver2022"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }

  boot_diagnostics {}

  lifecycle {
    prevent_destroy = true
    ignore_changes = [admin_password]
  }
}
