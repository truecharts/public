# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest AS builder

ARG VERSION

WORKDIR /app

# hadolint ignore=DL3002
USER root


# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3003,DL3016
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    nodejs \
    unzip \
    python \
    npm \
  && \
  export URL="https://github.com/Tzahi12345/YoutubeDL-Material/releases/download/v${VERSION}/youtubedl-material-v${VERSION}.zip" \
  && curl -fsSL -o /tmp/youtubedl.zip "${URL}" \
  && unzip /tmp/youtubedl.zip -d /tmp \
  && cp -Rf /tmp/youtubedl-material /app \
  && printf "UpdateMethod=docker\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && echo "==running NPM install==" \
  && npm install

# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ENV NO_UPDATE_NOTIFIER=true
ENV NODE_ENV=production
ENV APP_DIR="/app"

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION

# hadolint ignore=DL3002
USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG VERSION

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3003,DL3016
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    nodejs \
    youtube-dl \
    ffmpeg \
    unzip \
    python \
    ffmpeg \
    atomicparsley \
  && echo "==Running Cleanup ==" \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

COPY --from=builder --chown=apps:apps /app /app

USER apps

EXPOSE 17442
COPY ./.containers/apps/youtubedl/entrypoint.sh /entrypoint.sh
CMD [ "/entrypoint.sh" ]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "authors"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps/tree/master/.containers/apps/youtubedl"
LABEL "org.opencontainers.image.documentation "="https://truecharts.org"
