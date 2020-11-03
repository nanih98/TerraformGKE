# Outputs
# Registry containers
output "gcr_location" {
  value = data.google_container_registry_repository.gke_registry.repository_url
}

# GKE 
output "cluster_username" {
  value = google_container_cluster.gke_cluster.master_auth[0].username
}

output "cluster_password" {
  value = google_container_cluster.gke_cluster.master_auth[0].password
}

output "endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "node_config" {
  value = google_container_cluster.gke_cluster.node_config
}

output "node_pools" {
  value = google_container_cluster.gke_cluster.node_pool
}