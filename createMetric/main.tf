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

resource "azurerm_monitor_action_group" "mag_metric_demo" {
  name                = "metricAlertDemoMag"
  resource_group_name = module.m_rg_test.rg_name
  short_name          = "magDemo"


  email_receiver {
    name          = "BhupendraDemo"
    # email_address = "*****"
  }

}

module "m_rg_test" {
  source = "../modules/resourcegroup"

  name     = "demoMetricRG"
  location = "Central India"

}

module "m_log_a_ws_test" {
  source = "../modules/log-analytics-workspace"

  log_analytics_workspace_name     = "demo-metric-01"
  log_analytics_workspace_location = module.m_rg_test.rg_location

  rg_name = module.m_rg_test.rg_name

}



module "azure-metric" {
  source = "../modules/monitor-metrics-alert"

  rg_name                    = module.m_rg_test.rg_name
  scopes_id_list             = [module.m_log_a_ws_test.id]
  monitor_metrics_alert_list = var.metric_list
  metric_namespace           = var.metric_name_space
  action_list                = [{ action_group_id : azurerm_monitor_action_group.mag_metric_demo.id }]
}
