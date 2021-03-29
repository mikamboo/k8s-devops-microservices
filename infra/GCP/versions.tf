terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.56.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "1.13.3"
    }
    google-beta = {
      version = ">= 2.14"
    }
  }
}
