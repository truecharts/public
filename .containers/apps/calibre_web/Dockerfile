# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

ENV XDG_CONFIG_HOME=/config

USER root

COPY defaults/ /app

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
  apt-get -qq update \
  && \
  echo "**** install build packages ****" && \
  apt-get -qq install -y \
    git \
    libldap2-dev \
    libsasl2-dev \
    python3-pip && \
  echo "**** install runtime packages ****" && \
  apt-get -qq install -y \
    imagemagick \
    libnss3 \
    libxcomposite1 \
    libxi6 \
    libxslt1.1 \
    libldap-2.4-2 \
    libsasl2-2 \
    libxrandr2 \
    python3-minimal \
    python3-pkg-resources \
    unrar && \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='AMDx64' ;; \
  esac \
  && \
  curl -fsSL -o /tmp/calibre-web.tar.gz \
    "https://github.com/janeczku/calibre-web/archive/refs/tags/${VERSION}.tar.gz" \
  && tar ixzf /tmp/calibre-web.tar.gz -C /app --strip-components 1 \
  && \
  cd /app \
  && \
  pip3 install --no-cache-dir -U \
    pip && \
  pip install --no-cache-dir -U -r \
    requirements.txt -r \
    optional-requirements.txt && \
  printf "UpdateMethod=docker\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && \
  echo "***install kepubify" && \
  if [ -z ${KEPUBIFY_RELEASE+x} ]; then \
     KEPUBIFY_RELEASE=$(curl -sX GET "https://api.github.com/repos/pgaskin/kepubify/releases/latest" \
     | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
  /usr/bin/kepubify -L \
     https://github.com/pgaskin/kepubify/releases/download/${KEPUBIFY_RELEASE}/kepubify-linux-64bit && \
  && \
  chmod +x /usr/bin/kepubify \
  && \
  echo "**** create symlinks for imagemagick policy.xml ****" && \
    rm -f /etc/ImageMagick-6/policy.xml && \
    ln -s /app/defaults/policy.xml /etc/ImageMagick-6/policy.xml \
  && echo "**** cleanup ****" && \
  apt-get -y purge \
     libldap2-dev \
     libsasl2-dev \
     python3-pip && \
  apt-get clean \
  && \
  apt-get autoremove -y \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
    /root/.cache \
  && chmod -R u=rwX,go=rX /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

USER apps

EXPOSE 8083

COPY ./.containers/apps/calibre_web/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
