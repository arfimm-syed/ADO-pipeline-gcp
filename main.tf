
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/16"
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {

  name       = "primary-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  node_count = var.node_count

  node_config {

    machine_type = var.machine_type
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

  }
}