variable "app" {
  description = "Application name"
  default = "kuguru"
}

variable "dns_domain_name" {
  description = "SNS zone name, unique within the project."
  default = "kuguru-ga"
}

variable "dns_domain" {
  description = "DNS Zone domain"
  default = "kuguru.ga."
}

variable "dns_labels" {
  type        = map
  description = "A set of key/value label pairs to assign to DNS zone"
  default = {
    owner   = "terraform"
    version = "1"
  }
}

variable "credentials_file" {
  description = "Path to GCP service account auth file"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "europe-west3"
}

variable "zone" {
  description = "Zone au sein de la région"
  default = "europe-west3-a"
}

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "gke-terraform"
}

variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "gke-network"
}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-subnet"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-svc"
}