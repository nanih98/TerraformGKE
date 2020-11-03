# Configure default network tier (premium for large infrastructures that require high availability and large amounts of traffic)
resource "google_compute_project_default_network_tier" "default" {
  network_tier = "PREMIUM"
  project       = var.project_id
}

# Configure and create vpc for our GKE cluster
resource "google_compute_network" "vpc_network" {
  name = var.gke_vpc
  description = "Create custom vpc for GKE k8s cluster"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}

# Configure subnetwork for node_pools 
resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.gke_subnetwork
  description   = "Create custom subnetwork for our gke cluster"
  ip_cidr_range = "10.132.16.0/20"
  region        = var.gcp_location_regional
  network       = google_compute_network.vpc_network.id
}

# Secondary range for our cluster
resource "google_compute_subnetwork" "vpc_subnetwork2" {
  name          = var.gke_secondary_subnetwork
  description   = "Create custom secondary subnetwork for our gke cluster"
  ip_cidr_range = "10.128.16.0/20"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

# Create static ip for our loadbalancer L4 (created later with nginx and ingress controller)
resource "google_compute_address" "staticip_lb" {
  name = var.staticip_lb
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region       = var.gcp_location_regional
}
