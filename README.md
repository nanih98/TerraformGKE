# GOOGLE GKE CLUSTER (BETA)
# THIS REPO IS STILL IN PROCESS 
# DO NOT USE ON ENVIRONMENT PRODUCTION  

# Export GOOGLE_APPLICATION_CREDENTIALS

```sh
export GOOGLE_APPLICATION_CREDENTIALS=account.json
```
> Execute this command in the same directory where the account.json are located

# Terraform GKE cluster 

Build your own kubernetes cluster with GCP provider.

# Enable Kubernetes Engine API to allow access to your cluster with kubeconfig and kubectl cli  

gcloud container clusters get-credentials k8s-dani --zone europe-west1-c --project yourproject_id

# ENABLE Google Container Registry API  
gcloud auth configure-docker

# Pushing images to GCR

docker push gcr.io/YOUR_REGISTRY/ubuntu-latest

To see the url of your gcr repository, take a look of the output:

```
output "gcr_location" {
  value = data.google_container_registry_repository.gke_registry.repository_url
}
```

# GCP REGIONS  

https://cloud.google.com/compute/docs/regions-zones

# How to use   

## Create tfstate bucket
terraform plan --target google_storage_bucket.gcs_tfstate --out tfplan1.tfplan 
terraform init 


Clone this repository, then:

```sh
cd repo-folder
terraform init
terraform plan -out myfirstlaunch.tfplan
terraform apply myfirstlaunch.tfplan
```

**IMPORTANT:** download the json key of the service account that you must create previously.

