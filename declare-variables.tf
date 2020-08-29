# Google Cloud connection & authentication and Application configuration | variables-auth.tf


# define GCP region
variable "gcp_region_1" {
  type        = string
  description = "GCP region"
}

# define GCP zone
variable "gcp_zone_1" {
  type        = string
  description = "GCP zone"
}

# define Route53 access token
variable "access_key" {}

# define Route53 secret token
variable "secret_key" {}
