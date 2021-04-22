# hadolint ignore=DL3007
FROM ghcr.io/truecharts/alpine:latest

# Metadata params
ARG TARGETPLATFORM
ARG VERSION

# hadolint ignore=DL3002
USER root

SHELL ["/bin/sh", "-o", "pipefail", "-c"]


# hadolint ignore=DL3008,DL3013,DL3015,DL3017,DL3018,DL3019,SC2086,SC2155
RUN \
 echo "==> Upgrading apk and system..." \
 && apk --update --no-cache add \
        ca-certificates \
        git \
        openssh-client \
        openssl \
        python3\
        py3-pip \
        py3-cryptography \
        rsync \
        sshpass \
 && echo "==> Adding build-dependencies..." \
 && apk --update --no-cache add --virtual \
        .build-deps \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base \
        curl \
 && echo "==> Adding Python runtime..." \
 && pip3 install --no-cache-dir --upgrade \
        pip \
        cffi \
 && echo "==> Installing Ansible..." \
 && pip3 install --no-cache-dir \
        ansible==${VERSION} \
        ansible-lint \
 && apk del \
        .build-deps \
 && rm -rf /var/cache/apk/* \
 && echo "==> Cleaning up..." \
 && rm -rf /var/cache/apk/* \
 && echo "==> Adding hosts for convenience..." \
 && mkdir -p /etc/ansible /ansible \
 && echo "[local]" >> /etc/ansible/hosts \
 && echo "localhost" >> /etc/ansible/hosts


ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

WORKDIR /ansible/playbooks

COPY ./.containers/apps/ansible/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "authors"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps/tree/master/.containers/apps/bazarr"
LABEL "org.opencontainers.image.documentation "="https://truecharts.org"
