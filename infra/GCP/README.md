# TF create GKE cluster

Doc : [A Terraform module for configuring GKE clusters](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest)

1. Create GCP Project and get `project-id`
2. Create authorized [service account](https://console.cloud.google.com/apis/credentials/serviceaccountkey) and download json credentials file
3. Auth with GCloud `gcloud auth login`
4. Set GCloud project `gcloud config set project PROJECT_ID`

## Require to enable : 

- Access Management (IAM) API https://console.developers.google.com/apis/api/iam.googleapis.com/overview?project=xxxx
- Kubernetes Engine API https://console.developers.google.com/apis/api/container.googleapis.com/overview?project=xxxx
- Cloud Resource Manager API : https://console.developers.google.com/apis/library/cloudresourcemanager.googleapis.com?project=xxxx


## Links

* https://learn.hashicorp.com/tutorials/terraform/gke
* https://github.com/hashicorp/learn-terraform-provision-gke-cluster
* https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-destroy?in=terraform/gcp-get-started
* https://github.com/GoogleCloudPlatform/solutions-terraform-cloudbuild-gitops