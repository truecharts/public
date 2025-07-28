{{- define "immich.server" -}}
enabled: true
primary: true
imageSelector: image
resources:
  excludeExtra: true
securityContext:
  capabilities:
    disableS6Caps: true
envFrom:
  - configMapRef:
      name: server-config
  - configMapRef:
      name: common-config
  - secretRef:
      name: deps-secret
probes:
  liveness:
    enabled: true
    type: exec
    command: /usr/src/app/server/bin/immich-healthcheck
  readiness:
    enabled: true
    type: exec
    command: /usr/src/app/server/bin/immich-healthcheck
  startup:
    enabled: true
    type: exec
    command: /usr/src/app/server/bin/immich-healthcheck
{{- end -}}
