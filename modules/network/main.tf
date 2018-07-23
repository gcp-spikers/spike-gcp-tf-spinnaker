resource "google_compute_network" "spinnaker-default-network" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = "false"
  project                 = "${var.project}"
}
