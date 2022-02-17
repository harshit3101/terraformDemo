# Metric Alert  main


resource "azurerm_monitor_metric_alert" "r_monitor_metrics_alert" {

  for_each = { for item in var.monitor_metrics_alert_list : item.id => item }

  name                = each.value.name
  resource_group_name = var.rg_name
  scopes              = var.scopes_id_list

  description   = lookup(each.value, "description", null)
  severity      = lookup(each.value, "severity", null)
  auto_mitigate = lookup(each.value, "autoMitigate", null)
  frequency     = lookup(each.value, "evaluationFrequency", null)
  window_size   = lookup(each.value, "windowSize", null)

  dynamic "criteria" {
    for_each = length(keys(lookup(each.value, "criteria", {}))) > 0 ? { 1 : 1 } : {}

    content {
      metric_namespace = each.value.criteria.metric_namespace
      metric_name      = each.value.criteria.metric_name
      aggregation      = each.value.criteria.aggregation
      operator         = each.value.criteria.operator
      threshold        = each.value.criteria.threshold
      dynamic "dimension" {
        for_each = length(keys(lookup(each.value.criteria, "dimension", {}))) > 0 ? { 1 : 1 } : {}

        content {
          name     = each.value.criteria.dimension.name
          operator = each.value.criteria.dimension.operator
          values   = each.value.criteria.dimension.values
        }
      }
    }
  }


  dynamic "dynamic_criteria" {
    for_each = length(keys(lookup(each.value, "dynamic_criteria", {}))) > 0 ? { 1 : 1 } : {}

    content {
      metric_namespace  = each.value.dynamic_criteria.metric_namespace
      metric_name       = each.value.dynamic_criteria.metric_name
      aggregation       = each.value.dynamic_criteria.aggregation
      operator          = each.value.dynamic_criteria.operator
      alert_sensitivity = each.value.dynamic_criteria.alert_sensitivity
      dynamic "dimension" {
        for_each = length(keys(lookup(each.value.dynamic_criteria, "dimension", {}))) > 0 ? { 1 : 1 } : {}

        content {
          name     = each.value.dynamic_criteria.dimension.name
          operator = each.value.dynamic_criteria.dimension.operator
          values   = each.value.dynamic_criteria.dimension.values
        }
      }
    }
  }

  dynamic "application_insights_web_test_location_availability_criteria" {
    for_each = length(keys(lookup(each.value, "application_insights_web_test_location_availability_criteria", {}))) > 0 ? { 1 : 1 } : {}

    content {
      web_test_id           = each.value.application_insights_web_test_location_availability_criteria.web_test_id
      component_id          = each.value.application_insights_web_test_location_availability_criteria.component_id
      failed_location_count = each.value.application_insights_web_test_location_availability_criteria.failed_location_count
    }
  }

  dynamic "action" {
    for_each = { for item in var.action_list : item.action_group_id => item }

    content {
      action_group_id    = action.value.action_group_id
      webhook_properties = lookup(action.value, "webhook_properties", null)
    }
  }

}