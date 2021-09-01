ARG TARGETPLATFORM
ARG VERSION
# hadolint ignore=DL3007
FROM freeradius/freeradius-server:${VERSION}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN \
  rm /docker-entrypoint.sh && \
  rm -Rf /etc/raddb

VOLUME /etc/raddb
COPY ./containers/apps/freeradius/entrypoint.sh /docker-entrypoint.sh

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
