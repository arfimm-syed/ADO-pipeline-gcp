
terraform {
   backend "gcs" {
    bucket = "terraform-state-gcp-007"
    prefix = "terraform/state"
  }
}