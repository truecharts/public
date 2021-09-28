# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT="2"

# hadolint ignore=DL3007
FROM quay.io/helmpack/chart-releaser:v1.2.1 AS cr

# hadolint ignore=DL3007
FROM jnorwood/helm-docs:v1.5.0 AS hd

# hadolint ignore=DL3007
FROM quay.io/git-chglog/git-chglog:0.15.0 AS gcl

# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.154.0/containers/ruby/.devcontainer/base.Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

ARG HELM_VERSION="3.5.4"
ARG CT_VERSION=3.3.1
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED 1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=cr,source=/usr/local/bin,target=/crbin \
  cp /crbin/cr /usr/local/bin/cr

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=hd,source=/usr/bin/,target=/hdbin \
  cp /hdbin/helm-docs /usr/local/bin/helm-docs

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=gcl,source=/usr/local/bin,target=/gclbin \
  cp /gclbin/git-chglog /usr/local/bin/git-chglog

RUN \
  apt-get update \
  && \
  apt-get -y install --no-install-recommends \
    libonig-dev \
    gnupg2 \
  && \
  cd /tmp && \
  wget https://raw.githubusercontent.com/truecharts/apps/master/Gemfile && \
  cd - && \
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
  && \
  curl -o /tmp/helm.tar.gz "https://get.helm.sh/helm-v${HELM_VERSION}-linux-$(dpkg --print-architecture).tar.gz" \
  && tar xvzf /tmp/helm.tar.gz -C /usr/local/bin --strip-components 1 "linux-$(dpkg --print-architecture)/helm" \
  && chmod +x /usr/local/bin/helm \
  && \
  curl -o /tmp/ct.tar.gz -L "https://github.com/helm/chart-testing/releases/download/v${CT_VERSION}/chart-testing_${CT_VERSION}_linux_$(dpkg --print-architecture).tar.gz" \
  && mkdir -p /etc/ct \
  && tar xvzf /tmp/ct.tar.gz -C /usr/local/bin "ct" \
  && tar xvzf /tmp/ct.tar.gz --strip-components=1 -C /etc/ct "etc/" \
  && chmod +x /usr/local/bin/ct \
  && \
  bundle config set system 'true' \
  && bundle install --gemfile /tmp/Gemfile \
  && \
  rm -Rf \
    /tmp/Gemfile \
    /tmp/Gemfile.lock \
    /tmp/helm.tar.gz \
    /tmp/ct.tar.gz

RUN \
  apt-get update \
  && \
  apt-get -y install --no-install-recommends \
    python3-pip \
    python3-setuptools \
    debhelper-compat \
    dh-python \
    python3-dev \
    devscripts \
    python3-jsonschema \
    python3-semantic-version \
    python3-kubernetes \
    python3-yaml \
  && \
  cd /tmp && \
  git clone https://github.com/truenas/catalog_validation.git && \
  cd - && \
  cd /tmp/catalog_validation && \
  git checkout $(git describe --tags $(git rev-list --tags --max-count=1)) && \
  pip install -U . && \
  cd - && \
  rm -Rf \
    /tmp/catalog_validation

RUN \
  apt-get update \
  && \
  apt-get -y install --no-install-recommends \
    python3-pip \
  && \
  pip3 install \
    pre-commit \
    yamale \
    yamllint \
  && \
  mkdir /tmp/precommit/ && \
  cd /tmp/precommit && \
  wget https://raw.githubusercontent.com/truecharts/apps/master/.pre-commit-config.yaml && \
  git init . && \
  pre-commit install-hooks && \
  echo "installed pre-commit hooks:" && \
  ls ~/.cache/pre-commit/* && \
  cd - && \
  rm -Rf \
    /tmp/precommit
