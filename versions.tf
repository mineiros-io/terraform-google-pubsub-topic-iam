# ----------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.14.7, < 2.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.50, < 6.0"
    }
  }
}
