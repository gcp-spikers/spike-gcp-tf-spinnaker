resource "google_compute_instance" "spinnaker-service-machine" {
  name     = "spinnaker-service-machine"
  machine_type = "n1-standard-4"
  zone         = "australia-southeast1-a"
  project      = "${var.project}"

  boot_disk { 
    initialize_params {
      image = "ubuntu-1404-lts"
    }
  }

  network_interface {
    access_config = {}
    network = "default"
  }
}
