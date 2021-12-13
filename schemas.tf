locals {
  schemas = {
    "APP" = {
      database    = "WAREHOUSE_DB"
      comment     = "raw data from our source systems"
      usage_roles = ["TRANSFORMER"]
      all_roles   = ["LOADER"]
    }
    "ANALYTICS" = {
      database    = "WAREHOUSE_DB"
      comment     = "tables and views accessible for dashboards and analytics"
      usage_roles = []
      all_roles   = ["TRANSFORMER"]
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

resource "snowflake_schema_grant" "schema_grant_usage" {
  provider      = snowflake.sys_admin
  for_each      = local.schemas
  schema_name   = each.key
  database_name = each.value.database
  privilege     = "USAGE"
  roles         = each.value.usage_roles
  shares        = []
}

module "schema_grant_all" {
  source        = "github.com/chanzuckerberg/cztack//snowflake-schema-grant-all"
  providers     = {
    snowflake = snowflake.sys_admin
  }
  for_each      = local.schemas
  schema_name   = each.key
  database_name = each.value.database
  roles         = each.value.all_roles
  shares        = []
}