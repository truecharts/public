FROM docker.io/nextcloud:30.0.4-fpm@sha256:f6b2ec624555c8f63b0b5f8950b432e10352f522b571b66283f10d20b7ef62aa
# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL4006
RUN set -ex; \
    \
    echo "deb http://ftp.debian.org/debian $(cat /etc/os-release | grep VERSION_CODENAME | cut -d= -f2) non-free" >> \
    /etc/apt/sources.list.d/intel-graphics.list && \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        jq \
        nano \
        procps \
        ffmpeg \
        libheif1 \
        smbclient \
        libde265-0 \
        libfcgi-bin \
        heif-gdk-pixbuf \
        imagemagick-common \
        libmagickcore-6.q16-6-extra \
        intel-media-va-driver-non-free \
    ; \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libbz2-dev \
        libkrb5-dev \
        libc-client-dev \
        libsmbclient-dev \
        libmagickcore-dev \
    ; \
    \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-install \
        bz2 \
        imap \
    ; \
    pecl install smbclient; \
    docker-php-ext-enable smbclient; \
    \
    # Reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
        | awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); print so }' \
        | sort -u \
        | xargs -r dpkg-query --search \
        | cut -d: -f1 \
        | sort -u \
        | xargs -rt apt-mark manual; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

# Copy occ script to /usr/bin/occ
COPY --chmod=755 ./containers/apps/nextcloud-fpm/scripts/occ /usr/bin/occ

# Copy post-install script to a temp location so we can append it to the entrypoint.sh
COPY --chmod=755 ./containers/apps/nextcloud-fpm/scripts/post-install.sh /tmp/post-install.sh

# Copy the healthcheck
COPY --chmod=755 ./containers/apps/nextcloud-fpm/scripts/healthcheck.sh /healthcheck.sh

# Copy the configure-scripts that will be sourced by the post-install
COPY --chmod=755 ./containers/apps/nextcloud-fpm/configure-scripts /configure-scripts

RUN set -ex; \
    sed -i 's/exec "$@"//g' /entrypoint.sh; \
    cat /tmp/post-install.sh >> /entrypoint.sh

LABEL "org.opencontainers.image.source"="https://github.com/truecharts/containers"

ARG CONTAINER_NAME
ARG CONTAINER_VER
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
