resource "google_container_cluster" "spinnaker-primary" {
  name               = "spinnaker-primary"
  zone               = "australia-southeast1-a"
  initial_node_count = 3
  project            = "${var.project}"

  node_config {
    machine_type = "n1-standard-2"
    image_type   = "ubuntu"
  }
}
