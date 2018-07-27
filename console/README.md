# cloud tools in a container

## Dev environment setup

Due to the disparate setup rituals required, we're aiming to have all development config occur within a Docker image.

There's a high chance we'll bang against some limitations (eg. the `gcloud auth` command tries to launch a browser)

### Docker-based (experimental)

1. Build the image 

        docker build -f console/Dockerfile.gcloud -t engacc/cloud-dev:latest .

1. Open up a shell in the container

        docker run --publish-all --entrypoint "bash" \
        --mount type=bind,source="$(pwd)",target=/app,readonly \
        -it engacc/cloud-dev:latest