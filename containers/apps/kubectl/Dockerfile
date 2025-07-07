FROM tccr.io/truecharts/alpine:v3.18.4@sha256:cc37d84517c2d4420c67b618d87b6c88a367ec3afd6f5176ce4f7ae1fe4eeaf8

ARG TARGETPLATFORM
ARG VERSION

# hadolint ignore=DL3002
USER root

# hadolint ignore=DL3018,DL4006
RUN apk update && apk add --no-cache curl git \
    && curl -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl" \
    && curl -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl.sha256" \
    && echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && kubectl version --client --output=yaml \
    && curl -fsSL -o cmctl.tar.gz https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cmctl-linux-amd64.tar.gz \
    && tar xzf cmctl.tar.gz \
    && mv cmctl /usr/local/bin \
    && apk del curl


USER apps

ARG CONTAINER_NAME
ARG CONTAINER_VER
LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
