# hadolint ignore=DL3007
FROM ghcr.io/truecharts/alpine:latest

ARG VERSION
ARG TARGETPLATFORM

ENV BUILD_PACKAGES \
  bash \
  curl \
  tar \
  openssh-client \
  sshpass \
  nano \
  git \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-jinja2 \
  py-paramiko \
  py-pip \
  py-yaml \
  ca-certificates \
  openssl \
  python3\
  py3-pip \
  py3-cryptography \
  rsync \
  sshpass


# hadolint ignore=DL3002
USER root

SHELL ["/bin/sh", "-o", "pipefail", "-c"]


# hadolint ignore=DL3008,DL3013,DL3015,DL3017,DL3018,DL3019,SC2086,SC2155
RUN set -x && \
    \
    echo "==> Adding build-dependencies..."  && \
    apk --no-cache --update add --virtual build-dependencies \
      .build-deps \
      gcc \
      musl-dev \
      libffi-dev \
      openssl-dev \
      python3-dev \
    \
    echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
    \
    echo "==> Adding Python runtime..."  && \
    apk add --no-cache ${BUILD_PACKAGES} && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir python-keyczar docker-py && \
    \
    echo "==> Installing Ansible..."  && \
    pip install --no-cache-dir ansible==${VERSION} && \
    \
    echo "==> Cleaning up..."  && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    \
    echo "==> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible /ansible && \
    echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

WORKDIR /ansible/playbooks

ENTRYPOINT ["ansible-playbook"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "authors"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps/tree/master/.containers/apps/bazarr"
LABEL "org.opencontainers.image.documentation "="https://truecharts.org"
