# Variables. 
# IMPORTANT: All values for the following variables inside terraform.tfvars file
##########GCP DEFAULTS##########
variable "gcp_region" {
  type    = string
  default = "europe-west1"
}

variable "project_id" {
    type = string
    description = "GCP project_id"
}

##########Variables for GCS bucket##########
variable "gcs_bucket_name" {
    type = string
    description = "GCS bucket name to store terraform.tfstate remotely"
    default = "terraform-tfstate"
}

##########Custom tags for my project##########
variable "tags"  {
  type = map(string)

  default = {
    environment = "dev"
    project     = "mykubernetes"
  }
}

###########VPC for GKE cluster##########
variable "gke_vpc" {
    type = string
    default = "customvpcgke"
    description = "GKE VPC name for our custom k8s cluster with GKE"
}
variable "gke_subnetwork" {
    type = string
    default = "customsubnetworkgke"
    description = "Custom subnetwork goe our GKE cluster. This subnetwork will be created on gke_vpc"
}

variable "gke_secondary_subnetwork" {
    type = string
    default = "secondarysubnetwork"
    description = "Secondary subnetwork for our cluster"
}

variable "staticip_lb" {
    type = string
    description = "Static ip name that will be asigned to the loadbalancer on our GKE cluster"
    default = "staticip"
}

##########GKE cluster Variables##########
variable "gke_cluster_name" {
    type = string
    description = "Set your cluster name"
    default = "k8s-cluster"
}

variable "nodepool1_name" {
    type = string
    description = "Nodepool1 name added to the main GKE cluster"
    default = "nodepool1"
}

variable "gcp_location_regional" {
    type = string
    description = "Set regional zone name for our cluster"
    default = "europe-west1"
}

variable "gcp_location_zonal" {
    type = string
    description = "Set zonal name for our cluster"
    default = "europe-west1-c"
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(map(string))

  default = [
    {
      # External network that can access Kubernetes master through HTTPS.
      cidr_block = "0.0.0.0/0"
      # Field for users to identify CIDR blocks.
      display_name = "admingke"
    },
  ]
}