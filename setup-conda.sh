#!/usr/bin/env bash

# Create a virtual python environment for Ossian

eval "$(conda shell.bash hook)"
set -e

conda activate base
conda env remove -n ossian
rm -rf ossian.tar venv

#conda env create -f ossian.yml
mamba env create -f ossian-forge.yml

conda activate base
conda-pack -n ossian -o ossian.tar
mkdir -p venv
tar xf ossian.tar -C venv
./venv/bin/conda-unpack

rm ossian.tar
#conda env remove -n ossian
#conda clean -afy
