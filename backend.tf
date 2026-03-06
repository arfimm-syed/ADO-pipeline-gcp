
terraform {
    
  backend "gcs" {
    name = var.bucket_name
  }
}