# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  skip_provider_registration = true
}



module "m_rg_test" {
  source = "../modules/resourcegroup"

  name     = "demoMetricRG"
  location = "Central India"

}

resource "azurerm_monitor_action_group" "mag_metric_demo" {
  name                = "metricAlertDemoMag"
  resource_group_name = module.m_rg_test.rg_name
  short_name          = "magDemo"


  email_receiver {
    name          = "BhupendraDemo"
    # email_address = "*****"
  }

}

resource "azurerm_storage_account" "sa_metric_demo" {
  name                     = "metricalertdemosg"
  resource_group_name      = module.m_rg_test.rg_name
  location                 = module.m_rg_test.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


module "azure-metric" {
  source = "../modules/monitor-metrics-alert"

  rg_name                    = module.m_rg_test.rg_name
  scopes_id_list             = [azurerm_storage_account.sa_metric_demo.id]
  monitor_metrics_alert_list = var.metric_list

  action_list = [{ action_group_id : azurerm_monitor_action_group.mag_metric_demo.id }]
}
