#!/usr/bin/env bash

# Create a base image to speed up iterations

set -e

test -z "$1" &&  { echo "$LINENO: No container name" ; exit 1; }

container=$1-base

buildah rm $container || true

buildah from --name $container ubuntu:jammy-20220428

buildah run $container -- apt update
buildah run $container -- apt-get --yes install sox build-essential
buildah run $container -- apt-get clean
buildah run $container -- apt autoremove
buildah run $container -- rm -rf '/var/lib/apt/lists/*' '/tmp/*' '/var/tmp/*'

podman rmi -f $container || true

buildah commit --rm $container $container

echo -e "\nDone - $container\n"

