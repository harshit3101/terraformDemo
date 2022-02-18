metric_list = [
    {
  name        = "API Manager Unauthorized Requests",
  description = "API Manager Unauthorized Requests",
  severity    = "2",

  frequency   = 15,
  time_window = 15,
  query       = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.APIMANAGEMENT\" and MetricName == \"UnauthorizedRequests\" \n| summarize AggregatedValue=max(Maximum) by bin(TimeGenerated,15m), SubscriptionId, ResourceId, Asset=Resource, MetricName='UnauthorizedRequests'",
  trigger = {
    operator  = "GreaterThan",
    threshold = "15"
  },
  metric_trigger = {
    operator            = "GreaterThan",
    threshold           = "0",
    metric_trigger_type = "Consecutive",
    metric_column       = "ResourceId"
  }
  },
  {
    name        = "API Manager Failed Requests",
    description = "API Manager Failed Requests",
    severity    = "2",

    frequency   = 15,
    time_window = 15,
    query       = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.APIMANAGEMENT\" and MetricName == \"FailedRequests\" \n| summarize AggregatedValue=max(Maximum) by bin(TimeGenerated,15m), SubscriptionId, ResourceId, Asset = Resource, MetricName = 'FailedRequests'",
    trigger = {
      operator  = "GreaterThan",
      threshold = "15"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "API Manager Capacity high",
    description = "API Manager Capacity high",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.APIMANAGEMENT\"  \n| where MetricName == \"Capacity\" \n| summarize AggregatedValue=max(Maximum) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName='Capacity'",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Application Gateway Failed Requests",
    description = "Application Gateway Failed Requests",
    severity    = "1",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.NETWORK\"  \n| where MetricName == \"FailedRequests\" \n| summarize AggregatedValue=sum(Count) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName = 'FailedRequests'",
    trigger = {
      operator  = "GreaterThan",
      threshold = "20"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "5",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Web High CPU Time",
    description = "Web Application CPU Time over 95%",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.WEB\" \n| where MetricName == \"CpuTime\" \n| summarize AggregatedValue=avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName=\"CpuTime\"",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "3",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Web High CPU Percentage",
    description = "Web Application CPU over 95%",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.WEB\" \n| where MetricName == \"CpuPercentage\" \n| summarize AggregatedValue=avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName=\"CPUPercentage\"",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "3",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Web High Memory Percentage",
    description = "Web Application Memory over 95%",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.WEB\" \n| where MetricName == \"MemoryPercentage\" \n| summarize AggregatedValue=avg(Average) by bin(TimeGenerated, 5m), SubscriptionId, ResourceId, Asset=Resource, MetricName=\"MemoryPercentage\"",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "3",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Web High Disk Queue Length",
    description = "Web Application disk queue length over 40",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.WEB\" \n| where MetricName == \"DiskQueueLength\" \n| summarize AggregatedValue=avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName=\"DiskQueueLength\"",
    trigger = {
      operator  = "GreaterThan",
      threshold = "40"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "5",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Web High HTTP Queue Length",
    description = "Web High HTTP queue length over 50",
    severity    = "1",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.WEB\" \n| where MetricName == \"HttpQueueLength\" \n| summarize AggregatedValue=avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName='HttpQueueLength'",
    trigger = {
      operator  = "GreaterThan",
      threshold = "500"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "5",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL storage quota above threshold",
    description = "Azure SQL storage quota above threshold",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"storage_percent\" \n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "80"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL log write iops above threshold",
    description = "Azure SQL log write iops above threshold",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics\n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"log_write_percent\" \n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), TimeGenerated, MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "75"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL oltp storage quota above threshold",
    description = "Azure SQL oltp storage quota above threshold",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics\n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"xtp_storage_percent\"\n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), TimeGenerated, MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "90"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL read IOPS above threshold",
    description = "Azure SQL read IOPS above threshold",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"physical_data_read_percent\" \n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), TimeGenerated, MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "75"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL sessions above threshold",
    description = "Azure SQL sessions above threshold",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"sessions_percent\" \n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), TimeGenerated, MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "80"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL workers above threshold",
    description = "Azure SQL workers above threshold",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"workers_percent\" \n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "80"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "SQL CPU Percentage High",
    description = "SQL CPU Percentage High",
    severity    = "1",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.SQL\"  \n| where MetricName == \"cpu_percent\" \n| summarize AggregatedValue=avg(Maximum) by bin(TimeGenerated,5m),SubscriptionId, ResourceId, Asset=Resource, MetricName=\"cpu_percent\"",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "5",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "SQL Connection Failed",
    description = "SQL Connection Failed",
    severity    = "0",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.SQL\"  \n| where MetricName == \"connection_failed\" \n| summarize AggregatedValue=avg(Maximum) by bin(TimeGenerated,5m),SubscriptionId, ResourceId, Asset=Resource, MetricName=\"connection_failed\"",
    trigger = {
      operator  = "GreaterThan",
      threshold = "5"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "SQL High DTU",
    description = "SQL High DTU",
    severity    = "1",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where MetricName==\"dtu_consumption_percent\" \n| summarize AggregatedValue = max(Maximum) by bin(TimeGenerated, 5m), TimeGenerated, MetricName, Asset=Resource, ResourceId, SubscriptionId",
    trigger = {
      operator  = "GreaterThan",
      threshold = "75"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "3",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL - Managed Instance CPU Utilization High",
    description = "Azure SQL - Managed Instance CPU Utilization High",
    severity    = "2",

    frequency   = 30,
    time_window = 60,


    query = "AzureDiagnostics \n | where ResourceProvider == \"MICROSOFT.SQL\" and ResourceType == \"MANAGEDINSTANCES\" \n| project MetricValue= toreal(avg_cpu_percent_s), ResourceId, Category, SKU_s, LogicalServerName_s, TimeGenerated, TenantId, SubscriptionId, Type, ResourceType, Asset=Resource, MetricName = \"avg_cpu_percent\" \n| summarize AggregatedValue = max(MetricValue) by ResourceId, Category, SKU_s, LogicalServerName_s, TenantId, SubscriptionId, Type, ResourceType, Asset, MetricName, TimeGenerated=bin(TimeGenerated,30m)",
    trigger = {
      operator  = "GreaterThan",
      threshold = "85"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Azure SQL - Managed Instance Storage Quota Consumption",
    description = "Azure SQL - Managed Instance Storage Quota Consumption",
    severity    = "2",

    frequency   = 60,
    time_window = 60,


    query = "AzureDiagnostics \n| where ResourceProvider == \"MICROSOFT.SQL\" and ResourceType == \"MANAGEDINSTANCES\" \n | project MetricValue= toreal(storage_space_used_mb_s) / toreal(reserved_storage_mb_s) * 100 , ResourceId, Category, SKU_s, LogicalServerName_s, TimeGenerated , TenantId, SubscriptionId , Type, ResourceType, Asset=Resource, MetricName = \"StorageQuotaPct\" \n| summarize AggregatedValue = max(MetricValue) by  ResourceId, Category, SKU_s, LogicalServerName_s , TenantId, SubscriptionId , Type, ResourceType, Asset, MetricName, TimeGenerated=bin(TimeGenerated,60m)",
    trigger = {
      operator  = "GreaterThan",
      threshold = "85"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "MySQL - High Database Storage Quota",
    description = "MySQL - High Database Storage Quota",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider  == \"MICROSOFT.DBFORMYSQL\" \n| where MetricName == \"storage_percent\" \n| summarize  AggregatedValue = max(Maximum) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "75"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "MySQL - High Log Storage Quota",
    description = "MySQL - High Log Storage Quota",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider  == \"MICROSOFT.DBFORMYSQL\" \n| where MetricName == \"serverlog_storage_percent\" \n| summarize  AggregatedValue = max(Maximum) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "75"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "MySQL - High CPU Percentage",
    description = "MySQL - High CPU Percentage",
    severity    = "2",

    frequency   = 5,
    time_window = 30,


    query = "AzureMetrics \n| where ResourceProvider  == \"MICROSOFT.DBFORMYSQL\" \n| where MetricName == \"cpu_percent\" \n| summarize  AggregatedValue = avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "MySQL - Failed Connections",
    description = "MySQL - Failed Connections",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.DBFORMYSQL\" \n| where MetricName == \"connections_failed\" \n| summarize AggregatedValue=sum(Total) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "5"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "5",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "MySQL - High IO Consumption",
    description = "MySQL - High IO Consumption",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider  == \"MICROSOFT.DBFORMYSQL\" \n| where MetricName == \"io_consumption_percent\" \n| summarize  AggregatedValue = max(Maximum) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "75"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "MySQL - High Memory Percentage",
    description = "MySQL - High Memory Percentage",
    severity    = "1",

    frequency   = 5,
    time_window = 30,


    query = " AzureMetrics \n| where ResourceProvider  == \"MICROSOFT.DBFORMYSQL\" \n| where MetricName == \"memory_percent\" \n| summarize  AggregatedValue = avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "4",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Failed Activity Run Threshold Breached",
    description = "Failed Activity Run Threshold Breached",
    severity    = "1",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.DATAFACTORY\" and MetricName == \"ActivityFailedRuns\" \n| summarize AggregatedValue=sum(Total) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName = 'ActivityFailedRuns'",
    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "Failed Trigger Run Threshold Breached",
    description = "Failed Trigger Run Threshold Breached",
    severity    = "1",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.DATAFACTORY\" and MetricName == \"TriggerFailedRuns\" \n| summarize AggregatedValue=sum(Total) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName = 'TriggerFailedRuns'",
    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "0",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "DataFactory - High CPU Percentage",
    description = "DataFactory - High CPU Percentage",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider  == \"MICROSOFT.DATAFACTORY\" \n| where MetricName == \"IntegrationRuntimeCpuPercentage\" \n| summarize  AggregatedValue = avg(Average) by bin(TimeGenerated,5m), SubscriptionId, ResourceId, Asset=Resource, MetricName",
    trigger = {
      operator  = "GreaterThan",
      threshold = "95"
    },
    metric_trigger = {
      operator            = "GreaterThan",
      threshold           = "3",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "ExpressRoute BGP Availability",
    description = "ExpressRoute BGP Availability",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.NETWORK\" | where MetricName == \"BgpAvailability\" |  summarize AggregatedValue = min(Average) by Asset=Resource, MetricName, Type, ResourceId, SubscriptionId, ResourceGroup, bin(TimeGenerated, 5m)",
    trigger = {
      operator  = "GreaterThan",
      threshold = "1"
    },
    metric_trigger = {
      operator            = "LessThan",
      threshold           = "100",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  },
  {
    name        = "ExpressRoute ARP Availability",
    description = "ExpressRoute ARP Availability",
    severity    = "2",

    frequency   = 5,
    time_window = 5,

    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.NETWORK\" \n| where MetricName == \"ArpAvailability\" \n|  summarize AggregatedValue = min(Average) by Asset=Resource, MetricName, Type, ResourceId, SubscriptionId, ResourceGroup, bin(TimeGenerated, 5m)",
    trigger = {
      operator  = "GreaterThan",
      threshold = "1"
    },
    metric_trigger = {
      operator            = "LessThan",
      threshold           = "100",
      metric_trigger_type = "Consecutive",
      metric_column       = "ResourceId"
    }
  }
]