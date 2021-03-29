module "dns" {
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "3.1.0"
  project_id = var.project_id
  type       = "public"
  name       = "tf-${var.dns_domain_name}"
  domain     = var.dns_domain
  labels     = var.dns_labels

  recordsets = [
    # {
    #   name    = ""
    #   type    = "A"
    #   ttl     = 300
    #   records = [
    #     "34.107.53.140"
    #   ]
    # }
  ]
}


# Article : How to setup ExternalDNS to auto-manage DNS on GKE from ingress

# TODO: Setup ExternalDNS using gcloud module
# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
# https://github.com/terraform-google-modules/terraform-google-gcloud/blob/master/examples/simple_example/main.tf
# https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/nginx-ingress.md#gke-with-workload-identity
# https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

resource "google_service_account" "externaldns" {
  account_id   = "service-account-id"
  display_name = "Service Account for ExternalDNS"
}

resource "google_project_iam_member" "e-dns-dnsadmin-iam" {
  project            = var.project_id
  role               = "roles/dns.admin"
  member             = "serviceAccount:${google_service_account.externaldns.email}"
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  service_account_id = google_service_account.externaldns.name
  role               = "roles/iam.workloadIdentityUser"
  members            = [
    "serviceAccount:${var.project_id}.svc.id.goog[external-dns/external-dns]"
  ]
}
