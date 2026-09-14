variable "ad_admin_password" {
  description = "Senha administrativa para reconstruir a VM DC01."
  type        = string
  sensitive   = true
  default     = null
}

resource "azurerm_windows_virtual_machine" "ad" {
  name                = "DC01"
  computer_name       = "DC01"
  resource_group_name = "RG-LAB-WIN2025"
  location            = "northcentralus"
  size                = "Standard_B2as_v2"
  admin_username      = "luiz.adm"
  admin_password      = var.ad_admin_password

  network_interface_ids = [azurerm_network_interface.ad.id]

  provision_vm_agent        = true
  automatic_updates_enabled = true
  patch_mode                = "AutomaticByPlatform"
  patch_assessment_mode     = "ImageDefault"
  reboot_setting            = "IfRequired"
  hotpatching_enabled       = false
  secure_boot_enabled       = true
  vtpm_enabled              = true

  os_disk {
    name                 = "DC01_OsDisk_1_110c050a14454a9da6a07159743f59d7"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 127
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
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
