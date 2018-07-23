output "network-uri" {
  value = "${google_compute_network.spinnaker-default-network.self_link}"
}
