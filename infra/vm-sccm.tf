variable "sccm_admin_password" {
  description = "Senha administrativa local para reconstruir SCCM01."
  type        = string
  sensitive   = true
  default     = null
}

resource "azurerm_windows_virtual_machine" "sccm" {
  name                = "SCCM01"
  computer_name       = "SCCM01"
  resource_group_name = "RG-LAB-WIN2025"
  location            = "eastus"
  size                = "Standard_D2as_v7"
  admin_username      = "luizadmin"
  admin_password      = var.sccm_admin_password

  network_interface_ids = [azurerm_network_interface.sccm.id]

  provision_vm_agent        = true
  automatic_updates_enabled = true
  patch_mode                = "AutomaticByOS"
  patch_assessment_mode     = "ImageDefault"
  hotpatching_enabled       = false
  secure_boot_enabled       = true
  vtpm_enabled              = true

  os_disk {
    name                 = "SCCM01_OsDisk_1_e540d8a7eb574ac5b513e3ee97420fe1"
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
    ignore_changes  = [admin_password]
  }
}
