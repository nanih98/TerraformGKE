# Engine versions
data "google_container_engine_versions" "west1b" {
  provider       = google-beta
  project        = var.project_id
  location       = var.gcp_location_zonal
  version_prefix = "1.17"
}

# Create GKE CLUSTER
resource "google_container_cluster" "gke_cluster" {
name     = var.gke_cluster_name
location = var.gcp_location_zonal # use regional instead for multiple master (high availability)
description = "GKE CLUSTER TESTING DEVOPSTECH"
network = google_compute_network.vpc_network.name
subnetwork = google_compute_subnetwork.vpc_subnetwork.name
min_master_version = data.google_container_engine_versions.west1b.latest_node_version
node_version       = data.google_container_engine_versions.west1b.latest_node_version
resource_labels = var.tags
remove_default_node_pool = true
default_max_pods_per_node = 110
initial_node_count       = 1

    # Ip allocation policy
    ip_allocation_policy {
        cluster_secondary_range_name = var.gke_secondary_subnetwork
        services_secondary_range_name  = var.gke_secondary_subnetwork
    }

    # Network Policy
    # Configuration options for the NetworkPolicy feature.
    network_policy {
      # Whether network policy is enabled on the cluster. Defaults to false.
      # In GKE this also enables the ip masquerade agent
      # https://cloud.google.com/kubernetes-engine/docs/how-to/ip-masquerade-agent
      enabled = true

      # The selected network policy provider. Defaults to PROVIDER_UNSPECIFIED.
      provider = "CALICO"
    }

    # Allow access to master node from specific IP range
    master_authorized_networks_config {
        dynamic "cidr_blocks" {
          for_each = var.master_authorized_networks_cidr_blocks
          content {
            cidr_block   = cidr_blocks.value.cidr_block
            display_name = cidr_blocks.value.display_name
          }
        }
    }
    # Setup private cluster 
  private_cluster_config {
      enable_private_nodes = "true"
      enable_private_endpoint = "true"
      master_ipv4_cidr_block = "172.16.0.0/28"
  }

  # Configure addons
  addons_config {
    horizontal_pod_autoscaling {
        disabled = false
    }
    http_load_balancing{
        disabled = false
    }
    network_policy_config {
        disabled = false
    }
  }

  # Logging and monitoring
  logging_service = "none"
  monitoring_service = "none"

  # HTTP basic authentication when accessing the Kubernetes master endpoint.
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Create nodepool 
resource "google_container_node_pool" "nodepool1" {
  name       = var.nodepool1_name
  location   = var.gcp_location_zonal
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 3
  max_pods_per_node = 110

    node_config {
      machine_type = "e2-medium"
      disk_size_gb = "30"
      disk_type    = "pd-standard"
      labels       = var.tags

      oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
      ]
    }

    autoscaling {
        min_node_count = 3
        max_node_count = 6
    }

    management {
        auto_repair = true
        auto_upgrade = true
    }

}