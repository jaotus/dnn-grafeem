#!/usr/bin/env bash

# Run a small synthesize test

set -e

test ! -e voices &&  { echo "No voice!"; exit 1; }

mkdir -p corpus train voices test

exec podman run -i \
   -v ./corpus:/Ossian/corpus \
   -v ./train:/Ossian/train \
   -v ./voices:/Ossian/voices \
   -v ./test:/Ossian/test \
   quay.io/valents/dnn-grafeem:latest bash <./synthesize.sh
