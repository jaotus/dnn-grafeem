# Docker images for the _dnn-grafeem_ synthesizer

Create docker images for an Ossian based speech synthesizer.

## Build images
`setup.sh` is building two images:
- full Ossian synthesizer with training support for the new voices
- synthesizer only

The build scripts assume that you have
- __conda__ installed
- __mamba__ installed
- Ossian registration credentials in `setup-ossian.sh` (see [Ossian demo](http://jrmeyer.github.io/tts/2017/09/15/Ossian-Merlin-demo.html))
- TBD - verify all dependencies

NB! Scripts assume also that you are using Ubuntu 22.04 for building the images (__libc__ compatibility).
If you have a different distro, change the base image in `setup-base-image.sh` accordingly.

## Train a tiny voice

`test-train.sh` will use the image __dnn-grafeem-train__ to train a sample voice. 

Also the "synthesizer only" image __dnn-grafeem__ is available at
`quay.io/valents/dnn-grafeem:latest` and can be tested with `test-synthesize.sh`.

