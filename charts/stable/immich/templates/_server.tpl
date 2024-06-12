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
    command:
      - npm
      - run
      - healthcheck
  readiness:
    enabled: true
    type: exec
    command:
      - npm
      - run
      - healthcheck
  startup:
    enabled: true
    type: exec
    command:
      - npm
      - run
      - healthcheck
{{- end -}}
