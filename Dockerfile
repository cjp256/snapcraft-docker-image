ARG SNAPCRAFT_CHANNEL=edge
ARG UBUNTU_VERSION=xenial

FROM ubuntu:$UBUNTU_VERSION as builder

# Docker makes us redeclare ARG after FROM... :(
ARG SNAPCRAFT_CHANNEL

RUN echo "Building image from ubuntu:$UBUNTU_VERSION with snapcraft channel=$SNAPCRAFT_CHANNEL"

# Grab dependencies
RUN apt-get update && apt-get dist-upgrade --yes && apt-get install --yes \
      curl \
      jq \
      locales \
      snapd \
      squashfs-tools \
      sudo

# Generate locale.
RUN locale-gen en_US.UTF-8

# Because there is no snapd support in docker, we need a couple helpers
# to perform some of the work of snap/snapd.
RUN mkdir -p /snap/bin
COPY bin/snapcraft /snap/bin/snapcraft
COPY bin/snap-install /usr/bin/snap-install

# Use snap-install script to download and unpack the required snaps...
RUN /usr/bin/snap-install core
RUN /usr/bin/snap-install core18
RUN /usr/bin/snap-install snapcraft $SNAPCRAFT_CHANNEL

CMD /snap/bin/snapcraft
