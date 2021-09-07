# hadolint ignore=DL3007
FROM quay.io/helmpack/chart-releaser:v1.2.1 AS cr

# hadolint ignore=DL3007
FROM jnorwood/helm-docs:v1.5.0 AS hd

# hadolint ignore=DL3007
FROM mogensen/helm-changelog:v0.0.1 AS hcl

# hadolint ignore=DL3007
FROM quay.io/git-chglog/git-chglog:v0.15.0 AS gcl

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

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=hcl,source=/app,target=/hclbin \
  cp /hclbin/helm-changelog /usr/local/bin/helm-changelog

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=gcl,source=/usr/local/bin,target=/gclbin \
  cp /gclbin/git-chglog /usr/local/bin/git-chglog

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
