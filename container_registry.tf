# Setup our custom registry for our custom images (for pods)
resource "google_container_registry" "gke_registry" {
  location = "EU"
  project  = var.project_id
}

data "google_container_registry_repository" "gke_registry" {
}
