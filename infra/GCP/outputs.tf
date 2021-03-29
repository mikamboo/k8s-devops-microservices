output "cluster_name" {
  value = module.gke.name
}

output "cluster_location" {
  value = module.gke.location
}

output "endpoint" {
  sensitive = true
  value = module.gke.endpoint
}