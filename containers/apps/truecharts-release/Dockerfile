# hadolint ignore=DL3007
FROM quay.io/helmpack/chart-releaser:v1.2.1 AS cr

# hadolint ignore=DL3007
FROM jnorwood/helm-docs:v1.5.0 AS hd

# hadolint ignore=DL3007
FROM ixsystems/catalog_validation:latest

ARG TARGETPLATFORM
ARG VERSION

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=cr,source=/usr/local/bin,target=/crbin \
  cp /crbin/cr /usr/local/bin/cr

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=hd,source=/usr/bin/,target=/hdbin \
  cp /hdbin/helm-docs /usr/local/bin/helm-docs

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
