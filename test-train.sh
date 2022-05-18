#!/usr/bin/env bash

# Run a small test

set -e

test ! -e corpus/rm &&  tar xf ossian-download/romanian_toy_demo_corpus_for_ossian.tar

mkdir -p corpus train voices test

exec podman run -i \
   -v ./corpus:/Ossian/corpus \
   -v ./train:/Ossian/train \
   -v ./voices:/Ossian/voices \
   -v ./test:/Ossian/test \
   dnn-grafeem-train bash <./train.sh
