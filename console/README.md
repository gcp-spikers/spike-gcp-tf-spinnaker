# cloud tools in a container

## Dev environment setup

Due to the disparate setup rituals required, the aim is to have all development config occur within a Docker image.

~There's a high chance we'll bang against some limitations (eg. the `gcloud auth` command tries to launch a browser)~ (resolved without issue)

### Authentication

Currently the only prerequisite is to have a (generated) GCP account key .json file in the repository root.

The docker image expects the environment variable `GCLOUD_KEYFILE` to match this filename, but will default to `account.json`

See [this article](https://cloud.google.com/video-intelligence/docs/common/auth) for how to generate this. 

>*WARNING: If you don't use the default filename, ensure you include it in gitignore - if you accidentally push credentials the _must be immediately deleted and revoked_*

### Docker-based (experimental)

1. Set the `GCLOUD_PROJECT` environment variable to your GCP Project's name
        `export GCLOUD_PROJECT=[YOUR PROJECT ID]`
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