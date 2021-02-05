# TF create GKE cluster

Doc : [A Terraform module for configuring GKE clusters](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest)

1. Create GCP Project and get `project-id`
2. Create __Kubernetes Engine__ authorized [service account](https://console.cloud.google.com/apis/credentials/serviceaccountkey) and download json credentials file

## TODO

* [ ] Setup tf variables (project, credentials_file, ...)
* [ ] Secret encryption management

## Links

* https://learn.hashicorp.com/tutorials/terraform/gke
* https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-destroy?in=terraform/gcp-get-started
* https://github.com/GoogleCloudPlatform/solutions-terraform-cloudbuild-gitops