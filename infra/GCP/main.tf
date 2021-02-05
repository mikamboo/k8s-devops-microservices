provider "google" {
 credentials = file("CREDENTIALS_FILE.json")
 project     = "PROJECT_ID"
 region      = "us-west1"
}