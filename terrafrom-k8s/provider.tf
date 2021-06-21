terraform {
  backend "gcs" {
    credentials = "/Users/shashank/crispy-succotash/terrafrom-k8s/DevOps.json"
    bucket      = "devops-assignment"
    prefix      = "koppar-crispy/state"
  }
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.koppar-crispy.endpoint}"
  username               = google_container_cluster.koppar-crispy.master_auth.0.username
  password               = google_container_cluster.koppar-crispy.master_auth.0.password
  client_certificate     = base64decode(google_container_cluster.koppar-crispy.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.koppar-crispy.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.koppar-crispy.master_auth.0.cluster_ca_certificate)
}

provider "google" {
  credentials = "/Users/shashank/crispy-succotash/terrafrom-k8s/DevOps.json"
  project     = "crispy"
  region      = "europe-west1"
}
