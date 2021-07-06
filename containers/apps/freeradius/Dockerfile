ARG TARGETPLATFORM
ARG VERSION
# hadolint ignore=DL3007
FROM freeradius/freeradius-server:${VERSION}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN \
  mkdir -p /defaults/raddb/ && \
  cp -Rf /etc/raddb/* /defaults/raddb/

VOLUME /config
COPY ./containers/apps/freeradius/entrypoint.sh /entrypoint.sh

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
