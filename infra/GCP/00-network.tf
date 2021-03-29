# Create cluster isolated vpc
# https://cloud.google.com/vpc/docs/alias-ip?hl=fr
# https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/issues/423#issuecomment-779138297

resource "google_compute_network" "vpc" {
  name                    = "${var.cluster_name}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet pods
resource "google_compute_subnetwork" "subnet" {
  name               = "${var.cluster_name}-subnet"
  region             = var.region
  network            = google_compute_network.vpc.name
  ip_cidr_range      = "10.10.0.0/17"

  secondary_ip_range = [
    {
      range_name    = var.ip_range_pods_name
      ip_cidr_range = "192.168.0.0/18"
    },
    {
      range_name    = var.ip_range_services_name
      ip_cidr_range = "192.168.64.0/18"
    },
  ]
}