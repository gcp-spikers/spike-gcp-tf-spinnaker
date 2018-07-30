# cloud tools in a container

## Dev environment setup

Due to the disparate setup rituals required, the aim is to have all development config occur within a Docker image.

~There's a high chance we'll bang against some limitations (eg. the `gcloud auth` command tries to launch a browser)~ (resolved without issue)

### Docker-based (experimental)

1. Build the image 

        docker build -f console/Dockerfile.gcloud -t engacc/cloud-dev:latest .

1. Open up a shell in the container

        docker run --publish 8080:8080 --entrypoint "bash" \
        --mount type=bind,source="$(pwd)",target=/app,readonly \
        -it engacc/cloud-dev:latest
1. Once in the shell:

        $ cd /config
        $ ./gcloud-setup.sh
1. This:
        - installs tooling (helm, terraform)
        - provisions a service account and all resources
        - installs & runs spinnaker
        - performs a port-forward from the cloud instance to local docker via `kubectl port-forward`
        - You can confirm all is working with `curl localhost:8080`

## Roadmap

(See repository issues for more detail)

- [x] provision all GCP resources in-script
- [x] reproducible installation of all necessary tooling
- [x] install spinnaker
- [x] route from gcp to dev machine
        - [ ] expose forwarded port to docker host machine
        currently kubectl only forwards on the loopback interface (`127.0.0.1`) there are a number of duplicate Github issues open and a pull request adding interface selection, but it appears to have been deprioritised
        - [ ] use iptables to manually forward the loopback interface to `0.0.0.0`