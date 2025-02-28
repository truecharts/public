FROM tccr.io/tccr/alpine:v3.21.3@sha256:8ae22cc7c6f2dbc803e2d7e8aff41496d72a3ec4c2527501baac5f94360ed20a

ARG TARGETPLATFORM
ARG VERSION

# hadolint ignore=DL3002
USER root

COPY ./containers/apps/lvm-disk-watcher/includes/watch_lvm.sh /scripts/watch_lvm.sh

# hadolint ignore=DL3018,DL4006
RUN apk update && apk add --no-cache bash lvm2 lvm2-dmeventd device-mapper-event-libs \
    && apk del curl \
    && mkdir -p /scripts /config \
    && chmod +x /scripts/watch_lvm.sh

USER root

WORKDIR /scripts

ENTRYPOINT ["/bin/bash", "/scripts/watch_lvm.sh"]

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
