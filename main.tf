terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.22.0"
    }
  }
}

provider "snowflake" {
  alias  = "sys_admin"
  role   = "SYSADMIN"
}

provider "snowflake" {
    alias = "security_admin"
    role  = "SECURITYADMIN"
}