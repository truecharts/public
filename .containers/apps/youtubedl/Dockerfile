# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest AS builder


WORKDIR /extract/build

# hadolint ignore=DL3002
USER root
ARG VERSION
ENV VERSION=4.2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3003,DL3016
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    npm \
    build-essential

# hadolint ignore=DL3016
RUN npm install -g @angular/cli

RUN \
  export URL="https://github.com/Tzahi12345/YoutubeDL-Material/archive/refs/tags/v${VERSION}.tar.gz" \
  && curl -fsSL -o /tmp/youtubedl.tgz "${URL}" \
  && tar ixzf /tmp/youtubedl.tgz -C /extract --strip-components=1 \
  && cp /extract/package.json /extract/package-lock.json /extract/build

RUN \
  mkdir /extract/ffmpeg /
  && export URL2="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz" \
  && curl -fsSL -o /tmp/ffmpeg.tgz "${URL2}" \
  && tar ixzf /tmp/ffmpeg.tgz -C /extract/ffmpeg

# hadolint ignore=DL3016
RUN \
  echo "==running NPM install==" \
  && npm install \
  && cp /extract/angular.json /extract/tsconfig.json /extract/build \
  && cp -Rf /extract/src /extract/build \
  && ng build --prod


# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ENV NO_UPDATE_NOTIFIER=true
ENV NODE_ENV=production
ENV APP_DIR="/app"
env XDG_CACHE_HOME="/config/.cache"

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION

# hadolint ignore=DL3002
USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG VERSION

WORKDIR /app
COPY --chown=apps:apps --from=builder [ "/extract/backend/package.json", "/extract/backend/package-lock.json", "/app/" ]
COPY --chown=apps:apps --from=builder [ "/extract/ffmpeg/", "/app/ffmpeg/" ]
# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3003,DL3016
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    nodejs \
    npm \
    youtube-dl \
    unzip \
    python \
    ffmpeg \
    atomicparsley \
  && sudo ln -s "/app/ffmpeg/ffmpeg" /usr/local/bin/ \
  && sudo ln -s "/app/ffmpeg/ffprobe" /usr/local/bin/ \
  && mkdir /app/appdata || echo "" \
  && mkdir /config/.cache || echo "" \
  && mkdir /config/appdata || echo "" \
  && ln -s /app/appdata /config/appdata \
  && echo "==Installing youtubedl-material==" \
  && npm install \
  && printf "UpdateMethod=docker\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && echo "==Running Cleanup ==" \
  && apt-get remove -y \
    npm \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R 775 /app \
  && chmod -R 775 /config \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates \
  && chown -R apps:apps /app \
  && chown -R apps:apps /config

COPY --chown=apps:apps --from=builder [ "/extract/build/backend/public/", "/app/public/" ]
COPY --chown=apps:apps --from=builder [ "/extract/backend/", "/app/" ]

USER apps

EXPOSE 17442
COPY ./.containers/apps/youtubedl/entrypoint.sh /entrypoint.sh
CMD [ "/entrypoint.sh" ]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "authors"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps/tree/master/.containers/apps/youtubedl"
LABEL "org.opencontainers.image.documentation "="https://truecharts.org"
