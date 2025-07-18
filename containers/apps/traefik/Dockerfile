FROM public.ecr.aws/docker/library/traefik:3.4.4@sha256:82d2e26705a570b6d6778879d471cb3324687e77a6fd6883745a76c04563397a
# Above line used by CI to find tags etc

FROM public.ecr.aws/docker/library/alpine:3.22.0@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715 as plugins

# FIXME: Find a way to keep versions up to date
# -- Use the following prefixes to specify plugins to clone
# - TC_PLUGIN_REPO_* for the repo/package name
# - TC_PLUGIN_VERSION_* for the version

# Theme Park
ARG TC_PLUGIN_REPO_THEME_PARK=github.com/packruler/traefik-themepark
ARG TC_PLUGIN_VERSION_THEME_PARK_VERSION=v1.4.2
# GeoBlock
ARG TC_PLUGIN_REPO_GEOBLOCK=github.com/PascalMinder/geoblock
ARG TC_PLUGIN_VERSION_GEOBLOCK_VERSION=v0.2.8
# RealIP
ARG TC_PLUGIN_REPO_REALIP=github.com/jramsgz/traefik-real-ip
ARG TC_PLUGIN_VERSION_REALIP_VERSION=v1.0.6
# Modsecurity
ARG TC_PLUGIN_REPO_MODSECURITY=github.com/acouvreur/traefik-modsecurity-plugin
ARG TC_PLUGIN_VERSION_MODSECURITY_VERSION=v1.3.0
# Crowdsec
ARG TC_PLUGIN_REPO_CROWDSEC_BOUNCER=github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin
ARG TC_PLUGIN_VERSION_CROWDSEC_BOUNCER_VERSION=v1.3.5
# RewriteResponseHeaders
ARG TC_PLUGIN_REPO_REWRITERESPONSEHEADERS=github.com/XciD/traefik-plugin-rewrite-headers
ARG TC_PLUGIN_VERSION_REWRITERESPONSEHEADERS_VERSION=v0.0.4

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3018
RUN apk add --no-cache --update git

COPY --chmod=777 ./containers/apps/traefik/clone-plugins.sh /clone-plugins.sh
RUN /clone-plugins.sh

FROM traefik:v3.4.4@sha256:9b0e9d788816d722703eae57ebf8b4d52ad98e02b76f0362d5a040ef46902ef7
# Copy the plugins from the previous stage
COPY --from=plugins /plugins-local /plugins-local

LABEL "org.opencontainers.image.source"="https://github.com/truecharts/containers"

ARG CONTAINER_NAME
ARG CONTAINER_VER
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
