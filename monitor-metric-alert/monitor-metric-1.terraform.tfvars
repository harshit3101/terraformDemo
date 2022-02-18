metric_list = [
  {
    name          = "VM - Low Available MB Memory",
    description   = "VM - Low Available MB Memory",
    severity      = 2,
    auto_mitigate = true,
    frequency     = "PT30M",
    window_size   = "PT1H",
    criteria = {
      threshold   = 100,
      name        = "Metric1",
      metric_name = "Average_Available MBytes Memory",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "LessThan",
      aggregation = "Minimum"
    }
  },
  {
    name          = "VM Availability - Linux Uptime below threshold",
    description   = "VM Availability - Linux Uptime below threshold",
    severity      = 2,
    auto_mitigate = true,
    frequency     = "PT5M",
    window_size   = "PT15M",
    criteria = {
      threshold   = 600,
      name        = "Metric1",
      metric_name = "Average_Uptime",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "LessThan",
      aggregation = "Minimum"
    }
  },
  {
    name          = "Linux VM Swap",
    description   = "Linux VM Swap",
    severity      = 2,
    auto_mitigate = true,
    frequency     = "PT5M",
    window_size   = "PT15M",
    criteria = {
      threshold   = 95,
      name        = "Metric1",
      metric_name = "Average_% Used Swap Space",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Maximum"
    }
  },
  {
    name          = "Processor Utilization is High (Critical)",
    description   = "A monitored virtual machine is experiencing CPU utilization greater than 90%!",
    severity      = 1,
    auto_mitigate = false,
    frequency     = "PT15M",
    window_size   = "PT30M",
    criteria = {
      threshold   = 90,
      name        = "Metric1",
      metric_name = "Average_% Processor Time",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "ObjectName",
          operator = "Include",
          values = [
            "Processor"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Average"
    }
  },
  {
    name          = "Processor Utilization is High (Warning)",
    description   = "A monitored virtual machine is experiencing CPU utilization greater than 70%.",
    severity      = 2,
    auto_mitigate = false,
    frequency     = "PT15M",
    window_size   = "PT30M",
    criteria = {
      threshold   = 70,
      name        = "Metric1",
      metric_name = "Average_% Processor Time",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "ObjectName",
          operator = "Include",
          values = [
            "Processor"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Average"
    }
  },
  {
    name          = "Windows Service unexpected error",
    description   = "Windows Service unexpected error",
    severity      = 1,
    auto_mitigate = false,
    frequency     = "PT1M",
    window_size   = "PT5M",
    criteria = {
      threshold   = 0,
      name        = "Metric1",
      metric_name = "Event",
      dimensions = [
        {
          name     = "Source",
          operator = "Include",
          values = [
            "Service Control Manager"
          ]
        },
        {
          name     = "EventLog",
          operator = "Include",
          values = [
            "System"
          ]
        },
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "EventID",
          operator = "Include",
          values = [
            "7031",
            "7024",
            "7034"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Count"
    }
  },
  {
    name          = "Committed Memory percentage is high - Metric",
    description   = "Committed Memory percentage is high - Metric",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT30M",
    window_size   = "PT1H",
    criteria = {
      threshold   = 70,
      name        = "Metric1",
      metric_name = "Average_% Committed Bytes In Use",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Average"
    }
  },
  {
    name          = "VM - Free disk space percentage warning",
    description   = "VM - Free disk space percentage warning",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT30M",
    window_size   = "PT1H",
    criteria = {
      threshold   = 5,
      name        = "Metric1",
      metric_name = "Average_% Free Space",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "InstanceName",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "LessThanOrEqual",
      aggregation = "Minimum"
    }
  },
  {
    name          = "VM - Free disk space MB critical",
    description   = "VM - Free disk space MB critical",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT1M",
    window_size   = "PT5M",
    criteria = {
      threshold   = 1000,
      name        = "Metric1",
      metric_name = "Average_Free Megabytes",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "InstanceName",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "LessThanOrEqual",
      aggregation = "Minimum"
    }
  },
  {
    name          = "VM Stop Error",
    description   = "VM Stop Error",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT1M",
    window_size   = "PT5M",
    criteria = {
      threshold   = 0,
      name        = "Metric1",
      metric_name = "Event",
      dimensions = [
        {
          name     = "Source",
          operator = "Include",
          values = [
            "User32"
          ]
        },
        {
          name     = "EventLog",
          operator = "Include",
          values = [
            "System"
          ]
        },
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "EventID",
          operator = "Include",
          values = [
            "1001"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Total"
    }
  },
  {
    name          = "VM Availability - Restart or Shutdown Event",
    description   = "VM Availability - Restart or Shutdown Event",
    severity      = 1,
    auto_mitigate = false,
    frequency     = "PT1M",
    window_size   = "PT5M",
    criteria = {
      threshold   = 0,
      name        = "Metric1",
      metric_name = "Event",
      dimensions = [
        {
          name     = "Source",
          operator = "Include",
          values = [
            "User32"
          ]
        },
        {
          name     = "EventLog",
          operator = "Include",
          values = [
            "System"
          ]
        },
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "EventID",
          operator = "Include",
          values = [
            "1074"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Total"
    }
  },
  {
    name          = "Average Disk Queue length is high",
    description   = "Average Disk Queue length is high",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT30M",
    window_size   = "PT1H",
    criteria = {
      threshold   = 40,
      name        = "Metric1",
      metric_name = "Average_Current Disk Queue Length",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "InstanceName",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "GreaterThan",
      aggregation = "Average"
    }
  },
  {
    name          = "VM - Free disk space percentage critical",
    description   = "VM - Free disk space percentage critical",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT30M",
    window_size   = "PT1H",
    criteria = {
      threshold   = 1,
      name        = "Metric1",
      metric_name = "Average_% Free Space",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "InstanceName",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "LessThanOrEqual",
      aggregation = "Minimum"
    }
  },
  {
    name          = "VM - Free disk space MB warning",
    description   = "VM - Free disk space MB warning",
    severity      = 1,
    auto_mitigate = true,
    frequency     = "PT30M",
    window_size   = "PT1H",
    criteria = {
      threshold   = 5000,
      name        = "Metric1",
      metric_name = "Average_Free Megabytes",
      dimensions = [
        {
          name     = "Computer",
          operator = "Include",
          values = [
            "*"
          ]
        },
        {
          name     = "InstanceName",
          operator = "Include",
          values = [
            "*"
          ]
        }
      ],
      operator    = "LessThanOrEqual",
      aggregation = "Minimum"
    }
  }

]

