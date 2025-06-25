# hadolint ignore=DL3007
FROM mcr.microsoft.com/devcontainers/base:alpine

ARG VERSION
ARG CONTAINER_NAME
ARG CONTAINER_VER

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN apk update && \
  apk --no-cache add \
    age bash bind-tools ca-certificates curl direnv fish fzf \
    gettext git github-cli helm iputils jq k9s kubectl kustomize \
    python3 py3-pip moreutils openssh-client openssl starship yq \
    sshfs libc6-compat fuse && \
  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Install CLI tools via jpillora scripts
RUN for app in \
    "budimanjojo/talhelper!!?as=talhelper&type=script" \
    "fluxcd/flux2!!?as=flux&type=script" \
    "helmfile/helmfile!!?as=helmfile&type=script" \
    "kubecolor/kubecolor!!?as=kubecolor&type=script" \
    "kubernetes-sigs/krew!!?as=krew&type=script" \
    "siderolabs/talos!!?as=talosctl&type=script"; \
  do \
    echo "=== Installing ${app} ==="; \
    curl -fsSL "https://i.jpillora.com/${app}" | bash; \
  done

# Setup fish config and completions
RUN mkdir -p /home/vscode/.config/fish/{completions,conf.d} && \
  for tool in cilium flux helm helmfile k9s kubectl kustomize talhelper talosctl; do \
    if command -v "$tool" >/dev/null 2>&1; then \
      $tool completion fish > "/home/vscode/.config/fish/completions/${tool}.fish" || true; \
    fi; \
  done && \
  gh completion --shell fish > /home/vscode/.config/fish/completions/gh.fish || true && \
  stern --completion fish > /home/vscode/.config/fish/completions/stern.fish || true && \
  yq shell-completion fish > /home/vscode/.config/fish/completions/yq.fish || true

# Add aliases to fish config
RUN mkdir -p /home/vscode/.config/fish/conf.d && \
  printf '%s\n' \
  "alias ls lsd" \
  "alias kubectl kubecolor" \
  "alias k kubectl" \
  "alias task go-task" \
  > /home/vscode/.config/fish/conf.d/aliases.fish

# Setup direnv whitelist
RUN mkdir -p /home/vscode/.config/direnv && \
  tee /home/vscode/.config/direnv/direnv.toml > /dev/null <<EOF
[whitelist]
prefix = [ "/workspaces" ]
EOF

# Fix permissions for devcontainer user
RUN chown -R vscode:vscode /home/vscode/

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
