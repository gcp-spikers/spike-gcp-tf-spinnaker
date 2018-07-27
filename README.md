# spike-gcp-tf-spinnaker
Terraforming Spinnaker on GCP

## Dev environment setup

Due to the disparate setup rituals required, we're aiming to have all development config occur within a Docker image.

There's a high chance we'll bang against some limitations (eg. the `gcloud auth` command tries to launch a browser)

### Docker-based (experimental)

1. Build the image 

        docker build -f Dockerfile.gcloud -t engacc/cloud-dev:latest .
1. Open up a shell in the container

        docker run --entrypoint "bash" -it engacc/cloud-dev:latest
