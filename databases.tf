resource "snowflake_database" "database" {
  provider                    = snowflake.sys_admin
  name                        = "WAREHOUSE_DB"
  comment                     = "data and analytics database"
  data_retention_time_in_days = 1
}
