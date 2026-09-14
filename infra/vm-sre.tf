resource "azurerm_linux_virtual_machine" "sre" {
  name                = "SRELAB01"
  computer_name       = "SRELAB01"
  resource_group_name = "RG-LAB-SRE"
  location            = "northcentralus"
  size                = "Standard_B2as_v2"
  admin_username      = "azureuser"

  network_interface_ids = [azurerm_network_interface.sre.id]

  disable_password_authentication = true
  provision_vm_agent              = true
  secure_boot_enabled             = true
  vtpm_enabled                    = true
  patch_mode                      = "ImageDefault"
  patch_assessment_mode           = "ImageDefault"

  admin_ssh_key {
    username   = "azureuser"
    public_key = trimspace(file("${path.module}/srelab01.pub"))
  }

  os_disk {
    name                 = "SRELAB01_OsDisk_1_a92f548283e04fb5ae9e94d6b4a10cb1"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 64
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  boot_diagnostics {}

  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }

  lifecycle {
    prevent_destroy = true
  }
}
