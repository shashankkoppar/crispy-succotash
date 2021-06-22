resource "google_container_cluster" "koppar-crispy" {
  name       = var.cluster_name
  location   = var.region
  project    = var.project
  network    = "default"
  subnetwork = "default"

  remove_default_node_pool = true
  initial_node_count       = 1

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

resource "google_sql_database_instance" "postgres" {
  name             = "postgres-instance"
  database_version = "POSTGRES_11"
  region           = "europe-west1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name       = "postgres"
  instance   = "postgres-instance"
  password   = "password"
  depends_on = [google_sql_database_instance.postgres]
}

resource "google_sql_database" "database" {
  name       = "crispy"
  instance   = "postgres-instance"
  depends_on = [google_sql_database_instance.postgres]
}
