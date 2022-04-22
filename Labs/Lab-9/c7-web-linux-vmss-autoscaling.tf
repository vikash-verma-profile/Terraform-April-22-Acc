resource "azurerm_monitor_autoscale_setting" "web-vmss-autoscale" {
  name                = "web-vmss-autoscale"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.web_vmss.id

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["practiceaws551@gmail.com"]
    }
  }

  profile {
    name = "default"
    capacity {
      default  = 2
      minimum = 1
      maximum = 6
    }

    ##scale-out
    rule {
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }

      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        time_grain         = "PT1M"
        threshold          = 75
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        time_window        = "PT5M"
        statistic = "Average"
      }
    }

    ##scale-In
    rule {
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }

      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        time_grain         = "PT1M"
        threshold          = 25
        time_aggregation   = "Average"
        operator           = "LessThan"
        time_window        = "PT5M"
        statistic = "Average"
      }
    }
  }
}
