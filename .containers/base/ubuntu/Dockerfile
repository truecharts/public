ARG VERSION

FROM ghcr.io/k8s-at-home/ubuntu:v${VERSION}

ARG TARGETPLATFORM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN \
  usermod -l apps kah \
  && \
  groupmod -n apps kah \
  && chown -R apps:apps /config

# Patch CVE-2020-14040

RUN \
  go get -u golang.org/x/text

WORKDIR /app

USER apps

VOLUME [ "/config" ]

ENTRYPOINT [ "/usr/bin/tini", "--" ]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
