#!/bin/bash
set -e
echo "Starting build workflow"

scripts/docker_initialize.sh

# run build
echo "[${BRANCH_NAME}] Building image: ${IMAGE_FULLNAME}"
if [ "$BRANCH_NAME" = "master" ] || [ "$BRANCH_NAME" = "main" ]
then
    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t ${IMAGE_FULLNAME}:latest \
        --push .
else
    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t ${IMAGE_FULLNAME}-test:${BRANCH_NAME} \
        --push .
fi

# cleanup
scripts/docker_cleanup.sh
