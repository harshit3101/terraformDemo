metric_list = [
  {
    id          = "storage_test_1",
    name        = "Storage - Transaction greater than 0",
    description = "Storage - Transaction greater than 0",
    severity    = 2,

    criteria = {
      metric_namespace = "Microsoft.Storage/storageAccounts"
      metric_name      = "Transactions"
      aggregation      = "Total"
      operator         = "GreaterThan"
      threshold        = 0
      dimension = {
        name     = "ApiName"
        operator = "Include"
        values   = ["*"]
      }

    }
  }
]

