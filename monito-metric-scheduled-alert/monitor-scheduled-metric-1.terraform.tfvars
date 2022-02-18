metric_list = [

  {
    name        = "MySQL - Instance was Deleted",
    description = "MySQL - Instance was Deleted",
    severity    = "0",

    frequency   = 30,
    time_window = 30,


    query = "AzureActivity \n| where OperationName == \"Delete MySQL Server\" \n|  where ActivityStatus == \"Succeeded\" and ResourceProvider == \"Microsoft.DBforMySQL\" \n| project EventSubmissionTimestamp, Asset=Resource, ResourceId, OperationId, Caller, ResourceGroup, OperationName",

    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "MySQL - Instance was Restarted",
    description = "MySQL - Instance was Restarted",
    severity    = "0",

    frequency   = 30,
    time_window = 30,


    query = "AzureActivity \n| where OperationName == \"Restart MySQL Server\" \n|  where ActivityStatus == \"Succeeded\" and ResourceProvider == \"Microsoft.DBforMySQL\" \n| project EventSubmissionTimestamp, Asset=Resource, ResourceId, OperationId, Caller, ResourceGroup, OperationName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Security - VM Multiple Account Logon Failure",
    description = "Security - VM Multiple Account Logon Failure",
    severity    = "1",

    frequency   = 30,
    time_window = 30,


    query = "SecurityEvent | where EventID == 4625 | project Asset=Computer, AdditionalData=EventData, TenantId, Activity, MetricValue=EventID, MetricName=\"Event\", TargetAccount | summarize AggregatedValue = count() by TargetAccount, Asset, AdditionalData, TenantId, Activity, MetricValue, MetricName | where AggregatedValue > 1",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Azure SQL Storage capacity warning",
    description = "Azure SQL Storage capacity warning",
    severity    = "1",

    frequency   = 60,
    time_window = 60,


    query = "AzureMetrics \n| where ResourceProvider==\"MICROSOFT.SQL\" \n| where ResourceId contains \"/DATABASES/\" \n| where MetricName==\"storage_percent\" \n| where TimeGenerated > ago(60m) \n| where Maximum > 75 \n | summarize arg_max(TimeGenerated, *) by Resource",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Security - VM Cleared Security Event Logs",
    description = "Security - VM Cleared Security Event Logs",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "SecurityEvent | where (EventID == 1102 or EventID == 517) and EventSourceName == \"Microsoft-Windows-Eventlog\" | summarize AggregatedValue = count() by  Asset=Computer, AdditionalData=EventData, TenantId, Activity, MetricValue=EventID, MetricName=\"Event\", TargetAccount, EventSourceName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Backup - VM MARS Agent Backup Failure",
    description = "Backup - VM MARS Agent Backup Failure",
    severity    = "1",

    frequency   = 60,
    time_window = 60,


    query = "Event | where Source == \"CloudBackup\" | where EventLevelName != \"Information\" | project MetricName=Source, MetricValue=EventID, RenderedDescription , Asset=Computer, Type, EventData, EventLog, TimeGenerated, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "VM Availability - VM Stopped in Portal",
    description = "VM Availability - VM Stopped in Portal",
    severity    = "1",

    frequency   = 30,
    time_window = 30,


    query = "AzureActivity \n| where  ResourceProviderValue == \"MICROSOFT.COMPUTE\" and ActivityStatusValue == \"Start\" \n| where OperationNameValue == \"MICROSOFT.COMPUTE/VIRTUALMACHINES/DEALLOCATE/ACTION\" or OperationNameValue == \"MICROSOFT.COMPUTE/VIRTUALMACHINES/REDEPLOY/ACTION\" or OperationNameValue == \"MICROSOFT.COMPUTE/VIRTUALMACHINES/DELETE\"  \n| project EventSubmissionTimestamp, ResourceId=_ResourceId, OperationId=CorrelationId, Caller, ResourceGroup, OperationName=OperationNameValue",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Servers Pending Reboot for Update Installation",
    description = "Servers Pending Reboot for Update Installation",
    severity    = "3",

    frequency   = 1440,
    time_window = 1440,


    query = "WaaSDeploymentStatus | where DetailedStatus == \"Reboot pending\" | summarize DeviceCount = count() by ReleaseName, UpdateCategory, UpdateClassification | render table",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Updates Pending Restart",
    description = "Updates Pending Restart",
    severity    = "3",

    frequency   = 5,
    time_window = 5,


    query = "UpdateSummary | where RestartPending == True| project TimeGenerated, Asset=Computer, MetricName=\"RestartPending\", MetricValue=RestartPending",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "NET Performance - VPN High bandwidth utilization",
    description = "NET Performance - VPN High bandwidth utilization",
    severity    = "3",

    frequency   = 5,
    time_window = 5,


    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.NETWORK\" \n| where Maximum > 500000000 \n| project MetricName = \"AverageBandwidth\", MetricValue = Maximum, Asset=Resource, Type, ResourceId, SubscriptionId, ResourceGroup, Category, TimeGenerated",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "NET Performance - Expressroute High bandwidth utilization",
    description = "NET Performance - Expressroute High bandwidth utilization",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "AzureMetrics \n| where ResourceProvider == \"MICROSOFT.NETWORK\" \n| where MetricName == \"BitsOutPerSecond\" or MetricName  == \"BitsInPerSecond\" \n| where Maximum > 90000000 \n| summarize MetricValue = sum(Maximum) by Asset=Resource, MetricName = \"MaxBandwidth\", Type, ResourceId, SubscriptionId, ResourceGroup, Category, bin(TimeGenerated, 5m)",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Server Availability Group failover",
    description = "SQL Server Availability Group failover",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where Source == \"MSSQLSERVER\" \n| where EventID == \"26069\" \n| project TimeGenerated, ResourceId = _ResourceId, MetricName = Source, MetricValue = EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Server Database Backup Failed",
    description = "SQL Server Database Backup Failed",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where Source == \"MSSQLSERVER\" \n| where EventID == \"3041\" \n| project TimeGenerated, ResourceId = _ResourceId, MetricName=Source, MetricValue = EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Server Replica role changed",
    description = "SQL Server Replica role changed",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where Source == \"MSSQLSERVER\" \n| where EventID == \"19406\" \n|  project TimeGenerated, ResourceId = _ResourceId, MetricName = Source, MetricValue = EventID, RenderedDescription, Asset = Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Server logon failed",
    description = "SQL Server logon failed",
    severity    = "2",

    frequency   = 30,
    time_window = 30,


    query = "Event\n| where Source == \"MSSQLSERVER\"\n| where EventID == \"18456\"\n| parse kind = relaxed EventData with * '<Data>'SQL_LOGIN'</Data><Data>'ERROR_MSG'</Data><Data> [CLIENT= 'CLIENT_IP']</Data>' *\n| project TimeGenerated, ResourceId = _ResourceId, Asset = Computer, SQL_LOGIN, CLIENT_IP, ERROR_MSG, RenderedDescription\n| summarize AggregatedValue = count() by ResourceId, Asset, SQL_LOGIN, CLIENT_IP, ERROR_MSG, RenderedDescription\n| where AggregatedValue > 1",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Server agent job failed",
    description = "SQL Server agent job failed",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "Event\n| where Source == \"SQLSERVERAGENT\"\n| where EventID == \"208\"\n| parse kind=relaxed EventData with * '<Data>'Job_Name'</Data><Data>'Job_ID'</Data><Data>'Job_Status'</Data><Data>2020-'Invoked_On'</Data><Data>'Message'</Data></EventData></DataItem>' *\n| where Job_Status == \"Failed\"\n| summarize arg_max(TimeGenerated, *) by _ResourceId, Computer, Job_Name\n| project TimeGenerated, ResourceId = _ResourceId, MetricName=Source, MetricValue=EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Server filegroup out of space",
    description = "SQL Server filegroup out of space",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where Source == \"MSSQLSERVER\" \n| where EventID == \"1101\" \n| project TimeGenerated, ResourceId = _ResourceId, MetricName=Source, MetricValue=EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "SQL Lock Wait Time high",
    description = "SQL Lock Wait Time high",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "Perf \n| where ObjectName == \"SQLServer:Locks\" \n| where CounterName == \"Average Wait Time (ms)\" \n| where CounterValue > 500 \n| project TimeGenerated, Asset = Computer, ResourceId = _ResourceId, MetricName = CounterName, MetricValue = CounterValue, AdditionalData = CounterPath",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "VM Application fault",
    description = "VM Application fault",
    severity    = "3",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where EventLog == \"Application\" \n| where EventID == \"1000\" \n| project TimeGenerated, ResourceId = _ResourceId, MetricName = Source, MetricValue = EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "VM Availability - Unexpected Shutdown",
    description = "VM Availability - Unexpected Shutdown",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where EventLog == \"System\" \n| where EventID == \"6008\" \n| project TimeGenerated, ResourceId = _ResourceId, MetricName=Source, MetricValue=EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Missing endpoint protection",
    description = "Missing endpoint protection",
    severity    = "2",

    frequency   = 1440,
    time_window = 1440,


    query = "ProtectionStatus\r\n| where TypeofProtection == \"Malicious Software Removal Tool\" or TypeofProtection == \"No Anti-Malware Tool was detected\"\r\n| summarize arg_max(TimeGenerated, *) by Computer, TypeofProtection, ResourceId\r\n| project TimeGenerated, Asset=Computer, AdditionalData=TypeofProtection, ResourceId\n",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Windows Defender - Potential threat detected",
    description = "The threat state for Windows Defender/SCEP indicates whether or not a threat has been detected, and what action has been taken on that threat (if any).",
    severity    = "1",

    frequency   = 60,
    time_window = 60,


    query = "ProtectionStatus\r\n| where TypeofProtection == \"Windows Defender\" or TypeofProtection == \"System Center Endpoint Protection\"\r\n| where ThreatStatusRank > 150\r\n| summarize arg_max(TimeGenerated, *) by Computer, TypeofProtection, ResourceId, ThreatStatus, ThreatStatusDetails\r\n| project TimeGenerated, Asset=Computer, AdditionalData=TypeofProtection, ResourceId, outerMessage = ThreatStatus, innermostMessage = ThreatStatusDetails\n",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Windows Defender - Protection vulnerability detected",
    description = "The protection state for Windows Defender/SCEP can be degraded for several reasons, the most common being out of date signatures or scans.",
    severity    = "2",

    frequency   = 240,
    time_window = 240,


    query = "ProtectionStatus\r\n| where TypeofProtection == \"Windows Defender\" or TypeofProtection == \"System Center Endpoint Protection\"\r\n| where ProtectionStatusRank > 150 and ProtectionStatusRank < 550\r\n| summarize arg_max(TimeGenerated, *) by Computer, TypeofProtection, ResourceId, ProtectionStatus, ProtectionStatusDetails\r\n| project TimeGenerated, Asset=Computer, AdditionalData=TypeofProtection, ResourceId, outerMessage = ProtectionStatus, innermostMessage = ProtectionStatusDetails\n",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Local security group changed",
    description = "Local security group changed",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "SecurityEvent \n| where EventID == '4735' or EventID == '4733' or EventID == '4732' \n| where Channel == 'Security' \n| where SubjectAccount !endswith \"$\" \n| project Asset=Computer, AdditionalData=Activity, MetricValue=EventID, MetricName='SecurityEvent', ResourceId=_ResourceId, TimeGenerated, SubjectAccount, SubjectDomainName, TargetAccount",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "VM Availability - Heartbeat Failure",
    description = "VM Availability - Heartbeat Failure",
    severity    = "2",

    frequency   = 5,
    time_window = 30,


    query = "Heartbeat \n| where TimeGenerated > ago(2h) \n| summarize LastHeartbeat = max(TimeGenerated) by Computer, ComputerEnvironment, ResourceId \n| where isnotempty(Computer) \n| where LastHeartbeat < ago(15m) \n| project Asset = Computer, AdditionalData = LastHeartbeat, ComputerEnvironment, ResourceId",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "NTFS Errors",
    description = "NTFS Errors",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "Event \n| where Source == \"Microsoft-Windows-Ntfs\" \n| where EventLevelName == \"error\" \n| project TimeGenerated, ResourceId = _ResourceId, MetricName = Source, MetricValue = EventID, RenderedDescription, Asset=Computer, Type, EventData, EventLog, EventLevelName, UserName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Linux free disk space",
    description = "Linux free disk space",
    severity    = "2",

    frequency   = 15,
    time_window = 15,


    query = "Perf \n| where ObjectName == \"Logical Disk\" \n| where CounterName == \"Free Megabytes\" \n| where InstanceName !contains \"boot\" \n| where CounterValue < 1000\n| summarize arg_max(TimeGenerated, *) by Asset=Computer, ResourceId=_ResourceId, InstanceName\n| project Asset, ResourceId, ObjectName, InstanceName, CounterName, CounterValue",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Azure IaaS VM Agent Stopped",
    description = "The Azure IaaS VM Agent has stopped. This prevents normal functioning of this server, especially with WVD",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "ConfigurationChange | where SvcName == \"IaasVmProvider\" | where SvcState != \"Running\" | summarize AggregatedValue = count() by  Asset=Computer, _ResourceId, SvcName, SvcState, SvcPreviousState, SvcPath, SvcAccount, SvcStartupType",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Alert - VM Availability - No Telemetry",
    description = "No metric data has been seen for this virtual machine in a while. It is possible the machine is offline, but this otherwise indicates an issue.",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "AzureMetrics \n| where _ResourceId contains \"virtualmachines\" and TimeGenerated > ago(24h) \n| summarize max(TimeGenerated) by Resource, _ResourceId, SubscriptionId, ResourceGroup \n| where max_TimeGenerated < ago(30min)\n | project Asset=_ResourceId, Resource, SubscriptionId, ResourceGroup, max_TimeGenerated",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Windows Remote Desktop Services Agent Stopped",
    description = "TheWindows Remote Desktop Services Agent has stopped. This prevents normal functioning of this server, especially with WVD",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "ConfigurationChange | where SvcName == \"RdAgent\" | where SvcState != \"Running\" | summarize AggregatedValue = count() by  Asset=Computer, _ResourceId, SvcName, SvcState, SvcPreviousState, SvcPath, SvcAccount, SvcStartupType",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Azure Site Recovery Critical Health",
    description = "Azure Site Recovery Critical Health",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "AzureDiagnostics | where SourceSystem == \"Azure\" and Level == \"Critical\" and OperationName == \"AzureSiteRecoveryEvents\" | project TimeGenerated, ResourceId, SubscriptionId, MetricName=Category, MetricValue=description_s, AdditionalData=healthErrors_s, Asset=Resource, affectedResourceName_s",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Backup - Azure VM Managed Backup Failure",
    description = "Backup - Azure VM Managed Backup Failure",
    severity    = "2",

    frequency   = 60,
    time_window = 60,


    query = "AzureDiagnostics| where OperationName  == \"Job\" and JobOperation_s == \"Backup\" and JobStatus_s == \"Failed\"| where SchemaVersion_s == \"V2\"| where Category == \"AzureBackupReport\"| project MetricName=BackupManagementType_s , Level, BackupItemUniqueId_s , Type, ResourceId, Asset=Resource, JobOperation_s, MetricValue=JobStatus_s, Category, TimeGenerated",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Azure SQL Delete Activity",
    description = "Azure SQL Delete Activity",
    severity    = "1",

    frequency   = 60,
    time_window = 60,


    query = "AzureActivity \n| where OperationName == \"Delete SQL database\"  or OperationName == \"Delete SQL server\" \n| where ActivityStatus == \"Accepted\" and ResourceProvider == \"Microsoft SQL\" \n| project EventSubmissionTimestamp , Asset=ResourceId, OperationId, Caller, ResourceGroup, OperationName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "NET Availability - VPN Connectivity State Change",
    description = "NET Availability - VPN Connectivity State Change",
    severity    = "2",

    frequency   = 5,
    time_window = 5,


    query = "AzureDiagnostics |  where status_s == \"Disconnected\" or status_s == \"Connected\" and ResourceProvider == \"MICROSOFT.NETWORK\"\n| project status_s, instance_s, stateChangeReason_s, isNATed_b, tunnelType_s, remoteIP_s, MetricValue=OperationName, ResourceProvider, Asset=Resource, MetricName=ResourceType, Type, ResourceId, SubscriptionId, ResourceGroup, Category, TimeGenerated",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "New Azure Virtual Machine Created",
    description = "New Azure Virtual Machine Created",
    severity    = "3",

    frequency   = 60,
    time_window = 60,


    query = "AzureActivity \n| where OperationName == \"Create or Update Virtual Machine\" \n| where ActivityStatus == \"Succeeded\" and ResourceProvider == \"Microsoft.Compute\" \n| project EventSubmissionTimestamp, Asset=ResourceId, OperationId, Caller, ResourceGroup, OperationName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "DataFactory - Instance was Deleted",
    description = "DataFactory - Instance was Deleted",
    severity    = "0",

    frequency   = 30,
    time_window = 30,


    query = "AzureActivity \n| where OperationName == \"Delete Data Factory\" \n|  where ActivityStatus == \"Succeeded\" and ResourceProvider == \"Microsoft.DATAFACTORY\" \n| project EventSubmissionTimestamp, Asset=Resource, ResourceId, OperationId, Caller, ResourceGroup, OperationName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Application Insights - Web Test Availability",
    description = "Application Insights - Web Test Availability",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "availabilityResults \n| where  message !=\"Passed\" \n| project name, success, timestamp, location, message, duration, itemType, appId, appName, itemCount, Asset= strcat(name, \"-\", appName) \n| summarize AggregatedValue=count(success) by name, Asset, bin(timestamp, 5m), success, location, message, duration, MetricName=itemType, appId, MetricValue=itemCount, Resource=appName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "3"
    }
  },
  {
    name        = "Application Insights - Web Test HTTP 5xx Errors",
    description = "Application Insights - Web Test HTTP 5xx Errors",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "requests \n| where  resultCode startswith \"5\" \n| project url, success, timestamp, itemType, appId, appName, itemCount, Asset= strcat(name, \"-\", appName), resultCode \n| summarize AggregatedValue=count(resultCode) by  Asset, bin(timestamp, 5m), success, url, MetricName=itemType, appId, MetricValue=itemCount, Resource=appName, resultCode",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Application Insights - Web Test HTTP 4xx Errors",
    description = "Application Insights - Web Test HTTP 4xx Errors",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "requests \n| where resultCode startswith \"4\" \n| project url, success, timestamp, itemType, appId, appName, itemCount, Asset= strcat(name, \"-\", appName), resultCode \n| summarize AggregatedValue=count(resultCode) by Asset, bin(timestamp, 5m), success, url, MetricName=itemType, appId, MetricValue=itemCount, Resource=appName, resultCode",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Application Insights - Web Test Latency",
    description = "Application Insights - Web Test Latency",
    severity    = "1",

    frequency   = 5,
    time_window = 5,


    query = "availabilityResults \n| where  message ==\"Passed\" \n| project name, success, timestamp, location, message, duration, itemType, appId, appName, itemCount, Asset= strcat(name, \"-\", appName)  \n| summarize AggregatedValue=min(duration) by name, Asset, bin(timestamp, 5m), success, location, message, duration, MetricName=itemType, appId, MetricValue=itemCount, Resource=appName \n| where AggregatedValue > 500",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "AAS Server was Deleted",
    description = "AAS Server was Deleted",
    severity    = "0",

    frequency   = 30,
    time_window = 30,


    query = "AzureActivity \n| where OperationNameValue == \"Microsoft.AnalysisServices/servers/delete\" and ActivityStatusValue == \"Succeeded\" \n| project EventSubmissionTimestamp, Asset=Resource, ResourceId, OperationId, Caller, ResourceGroup, OperationName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "AAS Server was Suspended",
    description = "AAS Server was Suspended",
    severity    = "0",

    frequency   = 30,
    time_window = 30,


    query = "AzureActivity \n| where OperationNameValue == \"Microsoft.AnalysisServices/servers/suspend/action\" and ActivityStatusValue == \"Succeeded\" \n| project EventSubmissionTimestamp, Asset=Resource, ResourceId, OperationId, Caller, ResourceGroup, OperationName",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Automation Account Runbook Job Fails",
    description = "Automation Account Runbook Job Fails",
    severity    = "2",

    frequency   = 15,
    time_window = 15,


    query = "AzureDiagnostics \n| where ResourceProvider == \"MICROSOFT.AUTOMATION\" and Category == \"JobLogs\" and (ResultType == \"Failed\" or ResultType == \"Suspended\") \n| summarize AggregatedValue = count() by RunbookName_s",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Azure Data Factory Pipeline has failed",
    description = "Azure Data Factory Pipeline has failed",
    severity    = "2",

    frequency   = 15,
    time_window = 15,


    query = "ADFActivityRun \n| where Status == \"Failed\" \n| where ErrorMessage !contains \"Activity failed because an inner activity failed\" \n| project TimeGenerated, ResourceId, OuterMessage=PipelineName, Activity=OperationName, InnerMostMessage=ErrorMessage, AdditionalData=PipelineRunId",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "AUM has failed to install updates",
    description = "Azure Patch Management has failed to install update(s) during a scheduled deployment. See alert context for full details",
    severity    = "2",

    frequency   = 1440,
    time_window = 1440,


    query = "UpdateRunProgress \n| where InstallationStatus == \"FailedToStart\" or InstallationStatus == \"Failed\" or InstallationStatus == \"MaintenanceWindowExceeded\" or InstallationStatus == \"InstallFailed\" \n| project Computer, InstallationStatus, _ResourceId, UpdateRunName, Title, TimeGenerated \n| summarize count() by Asset = Computer, AdditionalData=UpdateRunName, _ResourceId",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  },
  {
    name        = "Windows has failed to install updates",
    description = "Windows has failed to install update(s). See alert context for more details.",
    severity    = "2",

    frequency   = 1440,
    time_window = 1440,


    query = "Event \n| where EventID == 20 and Source == \"Microsoft-Windows-WindowsUpdateClient\" \n| summarize count() by Computer, _ResourceId \n| project Asset=Computer, ResourceId=_ResourceId, MetricValue=count_, MetricName=\"FailedUpdatesCount\"",



    trigger = {
      operator  = "GreaterThan",
      threshold = "0"
    }
  }

]