#!/usr/bin/env bash

set -e

container=dnn-grafeem

./download-tools.sh
./setup-ossian.sh
./setup-conda.sh
./setup-base-image.sh $container
./setup-image.sh $container

echo "Done!"
