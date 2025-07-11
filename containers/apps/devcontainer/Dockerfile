# hadolint ignore=DL3007
FROM mcr.microsoft.com/devcontainers/base:alpine@sha256:6db48b9adf6af16ceedf327119a7ef68557368df42a780361976dee1734f9fd2

ARG CLUSTERTOOL_VERSION=2.0.0
ARG CONTAINER_NAME

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN apk update && \
  apk --no-cache add \
    age bash bind-tools ca-certificates curl direnv fish fzf \
    gettext git github-cli helm iputils jq k9s kubectl kustomize \
    python3 py3-pip moreutils openssh-client openssl starship yq \
    sshfs libc6-compat fuse && \
  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
        go-task sops

RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
        cilium-cli kubeconform stern

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

# Create the completions and conf.d directories explicitly
RUN mkdir -p /home/vscode/.config/fish/completions && \
    mkdir -p /home/vscode/.config/fish/conf.d

# Add completions only if the command exists
RUN for tool in cilium flux helm helmfile k9s kubectl kustomize talhelper talosctl; do \
      if command -v "$tool" >/dev/null 2>&1; then \
        mkdir -p /home/vscode/.config/fish/completions && \
        $tool completion fish > "/home/vscode/.config/fish/completions/${tool}.fish" || true; \
      fi; \
    done && \
    gh completion --shell fish > /home/vscode/.config/fish/completions/gh.fish || true && \
    stern --completion fish > /home/vscode/.config/fish/completions/stern.fish || true && \
    yq shell-completion fish > /home/vscode/.config/fish/completions/yq.fish || true

RUN mkdir -p /home/vscode/.config/fish/conf.d && \
    printf '%s\n' \
    "if status is-interactive" \
    "    direnv hook fish | source" \
    "    starship init fish | source" \
    "end" \
    > /home/vscode/.config/fish/conf.d/hooks.fish

# Add aliases to fish config
RUN mkdir -p /home/vscode/.config/fish/conf.d && \
  printf '%s\n' \
  "alias kubectl kubecolor" \
  "alias k kubectl" \
  "alias task go-task" \
  > /home/vscode/.config/fish/conf.d/aliases.fish

# Custom fish prompt
RUN mkdir -p /home/vscode/.config/fish/conf.d && \
    echo "set fish_greeting" > /home/vscode/.config/fish/conf.d/fish_greeting.fish

# Setup direnv whitelist
RUN mkdir -p /home/vscode/.config/direnv && \
  tee /home/vscode/.config/direnv/direnv.toml > /dev/null <<EOF
[whitelist]
prefix = [ "/workspaces" ]
EOF

# Fix permissions for devcontainer user
RUN chown -R vscode:vscode /home/vscode/
RUN chmod -R 755 /home/vscode/

# Download and set up the clustertool binary
RUN curl -L "https://github.com/truecharts/public/releases/download/v${CLUSTERTOOL_VERSION}/clustertool_${CLUSTERTOOL_VERSION}_linux_amd64.tar.gz" -o /tmp/clustertool.tar.gz \
    && tar -xzvf /tmp/clustertool.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/clustertool \
    && rm /tmp/clustertool.tar.gz

# Maintainer and metadata
LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
LABEL org.opencontainers.image.licenses="All-Rights-Reserved"
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CLUSTERTOOL_VERSION}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
