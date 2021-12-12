locals {
  schemas = {
    "APP" = {
      database = "WAREHOUSE_DB"
      comment  = "raw data from our source systems"
    }
    "ANALYTICS" = {
      database = "WAREHOUSE_DB"
      comment  = "tables and views accessible for dashboards and analytics"
    }
  }
}

resource "snowflake_schema" "schema" {
  provider = snowflake.sys_admin
  for_each = local.schemas
  name     = each.key
  database = each.value.database
  comment  = each.value.comment
}