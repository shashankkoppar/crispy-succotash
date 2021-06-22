terraform {
  backend "gcs" {
    credentials = "/Users/shashank/Downloads/wk/crispy-317519-dab2684f936f.json"
    bucket      = "crispy-bucket"
    prefix      = "crispy/state"
  }
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.koppar-crispy.endpoint}"
  client_certificate     = base64decode(google_container_cluster.koppar-crispy.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.koppar-crispy.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.koppar-crispy.master_auth.0.cluster_ca_certificate)
}

provider "google" {
  credentials = "/Users/shashank/Downloads/wk/crispy-317519-dab2684f936f.json"
  project     = "crispy-317519"
  region      = "europe-west1"
}
