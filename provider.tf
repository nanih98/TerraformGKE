provider "google" {
  credentials = file("account.json")
  project     = var.project_id
  region      = var.gcp_region
  version     = "~> 3.5"
}

# If you want to test with google beta features
#provider "google-beta" {
#  version = "~> 3.5"
#  project = var.projet_id
#  region  = local.gcp_region
#}