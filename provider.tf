# setup the GCP provider 

terraform {
  required_version = ">= 0.12"
}

provider "google" {
  project     = "rebrain"
  credentials = file("key.json")
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}

provider "google-beta" {
  project     = "rebrain "
  credentials = file("key.json")
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}

