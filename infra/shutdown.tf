locals {
  shutdown_schedules = {
    ad = {
      vm_id    = azurerm_windows_virtual_machine.ad.id
      location = "northcentralus"
      timezone = "E. South America Standard Time"
    }
    client = {
      vm_id    = azurerm_windows_virtual_machine.client.id
      location = "eastus"
      timezone = "E. South America Standard Time"
    }
    sccm = {
      vm_id    = azurerm_windows_virtual_machine.sccm.id
      location = "eastus"
      timezone = "UTC"
    }
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "lab" {
  for_each = local.shutdown_schedules

  virtual_machine_id    = each.value.vm_id
  location              = each.value.location
  enabled               = true
  daily_recurrence_time = "2300"
  timezone              = each.value.timezone

  notification_settings {
    enabled         = true
    time_in_minutes = 30
    email           = "lvbeserra0@gmail.com"
  }

  lifecycle {
    prevent_destroy = true
  }
}
