# spike-gcp-tf-spinnaker

## ⚠ This repository documented a spike of installation process, and has been superceded by a pure Terraform solution [here](https://github.com/gcp-spikers/gke-terraform-helm-spinnaker)

Spike for provisioning Spinnaker on GCP

- `/modules`
  - collection of terraform modules for building the infrastructure
- `/console`
  - a Docker image to provision all local tools and authentication (hopefully)
  - intention is to explore accelerating setup + consistency
  - see the associated README
- `/gcp-base-deployment`
  - early deployment-manager setup (seems to have been copied in from another source)

  
