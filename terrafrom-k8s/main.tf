resource "google_container_cluster" "koppar-crispy" {
  name       = var.cluster_name
  location   = var.region
  project    = var.project
  network    = "default"
  subnetwork = "default"

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = "koppar"
    password = "koppar-crispy-assignment"

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "node_pool" {
  name       = "koppar-crispy-node-pool"
  location   = var.region
  cluster    = var.cluster_name
  project    = var.project
  node_count = 1

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.admin",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management",
    ]
  }
  depends_on = [google_container_cluster.koppar-crispy]
}
