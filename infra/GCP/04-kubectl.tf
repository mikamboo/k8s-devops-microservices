
locals {
  k8s_manifest_files = "${path.module}/manifests"
  k8s_manifest_kong_ingress = "https://bit.ly/kong-ingress-dbless"
  k8s_manifest_cert_manager = "https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.yaml"
}

# Deploy cert-manager
# https://cert-manager.io/docs/installation/kubernetes
module "kubectl-cm" {
  source = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"

  project_id              = var.project_id
  cluster_name            = module.gke.name
  cluster_location        = module.gke.location
  module_depends_on       = [module.gke.endpoint]
  kubectl_create_command  = "kubectl apply -f ${local.k8s_manifest_cert_manager}"
  kubectl_destroy_command = "kubectl delete -f ${local.k8s_manifest_cert_manager}"
  skip_download           = true
}

# Deploy Kong ingress controller
module "kubectl-kong" {
  source = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"

  project_id              = var.project_id
  cluster_name            = module.gke.name
  cluster_location        = module.gke.location
  module_depends_on       = [module.gke.endpoint]
  kubectl_create_command  = "kubectl apply -f ${local.k8s_manifest_kong_ingress}"
  kubectl_destroy_command = "kubectl delete -f ${local.k8s_manifest_kong_ingress}"
  skip_download           = true
}

# Deploy local manifests
module "kubectl-setup" {
  source = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"

  project_id              = var.project_id
  cluster_name            = module.gke.name
  cluster_location        = module.gke.location
  module_depends_on       = [module.gke.endpoint, module.kubectl-cm.wait, module.kubectl-kong.wait]
  kubectl_create_command  = "kubectl apply -f ${local.k8s_manifest_files}"
  kubectl_destroy_command = "kubectl delete -f ${local.k8s_manifest_files}"
  skip_download           = true
}