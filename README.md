# Creating docker containers for snapcraft

## Setup

    sudo snap install docker

Ensure networking works, in some cases `dockerd` might need to have something
like `--dns=8.8.8.8` added to the command.

## Creating containers

The Dockerfile here can build images for any channel of snapcraft, notably the
following images are available as tags:

- **edge**: Using the snap from edge
- **beta**: Using the snap from beta
- **candidate**: Using the snap from candidate
- **stable**: Using the snap from stable

By default, the `edge` image will be built. Pass `--build-arg SNAPCRAFT_CHANNEL=<channel>`
to override the channel.

By default, the image will be Ubuntu 16.04.  Pass `--build-arg UBUNTU_VERSION=<version>`
to override the ubuntu image.

To build:

    docker build --no-cache --tag snapcore/snapcraft .

To build with custom snapcraft channel and ubuntu version:

    docker build --no-cache --tag snapcore/snapcraft --build-arg SNAPCRAFT_CHANNEL=edge --build-arg UBUNTU_VERSION=18.04 .

You can push that image with:

    docker push snapcore/snapcraft:<snapcraft-channel>
