#resource "google_storage_bucket" "gcs_tfstate" {
#  name          = var.gcs_bucket_name
#  location      = "EUROPE-WEST1"
#  storage_class = "STANDARD"
#  labels        = var.tags
#
#  # Enable versioning to retain all tfstate versions
#  versioning {
#    enabled = "true"
#  }
#
#}
