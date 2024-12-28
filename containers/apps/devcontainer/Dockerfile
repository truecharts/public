# hadolint ignore=DL3007
FROM ghcr.io/onedr0p/cluster-template/devcontainer:latest@sha256:90bd47adcf1ac31e8d60e028e521db7a203a16186685546c298a5bb5e7ff642b

ARG VERSION
ARG CONTAINER_NAME
ARG CONTAINER_VER

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN \
apk update && \
  apk --no-cache update && \
  apk --no-cache add \
    sshfs \
    libc6-compat \
    fuse && \
  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Download and set up the clustertool binary
RUN curl -L "https://github.com/truecharts/public/releases/download/v${VERSION}/clustertool_${VERSION}_linux_amd64.tar.gz" -o /tmp/clustertool.tar.gz \
    && tar -xzvf /tmp/clustertool.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/clustertool \
    && rm /tmp/clustertool.tar.gz

# Download and set up the krew binary
RUN curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" \
    && tar zxvf "krew-linux_amd64.tar.gz" \
    && ./"krew-linux_amd64" install krew \
    && rm ./krew-linux_amd64.tar.gz

ENV PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# add pvmounter to kubectl using crew
RUN kubectl krew install pv-mounter

# Maintainer and metadata
LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
LABEL org.opencontainers.image.licenses="All-Rights-Reserved"
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
