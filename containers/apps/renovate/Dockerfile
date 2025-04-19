# hadolint ignore=DL3007
FROM docker.io/renovate/renovate:39.245.3-full@sha256:4e9514a6b439bd26930cd502d42c32ab2906881c09f7c87f0c228eee850844e0

ARG VERSION
ARG CONTAINER_NAME
ARG CONTAINER_VER
ARG TEST

# Download and set up the clustertool binary
RUN curl -L "https://github.com/truecharts/public/releases/download/v${VERSION}/clustertool_${VERSION}_linux_amd64.tar.gz" -o /tmp/clustertool.tar.gz \
    && tar -xzvf /tmp/clustertool.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/clustertool \
    && rm /tmp/clustertool.tar.gz


# Maintainer and metadata
LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
