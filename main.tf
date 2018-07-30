provider "google" {
  region      = "${var.region}"
  credentials = "account.json"
}

terraform {
  backend "gcs" {
    credentials = "account.json"
    region      = "australia-southeast1"
    bucket      = "terraform-bucket-on-mountain"
  }
}

# module "service-machine" {
#   source = "modules/service-machine"
#   project = "${var.project}"
#   network-uri = "${module.network.network-uri}"
# }

# module "network" {
#   source = "modules/network"
#   project = "${var.project}"
# }

module "kube-cluster" {
  source  = "modules/kube-cluster"
  project = "${var.project}"
}

module "spinnaker-service-account" {
  source  = "modules/spinnaker-service-account"
  project = "${var.project}"
}
