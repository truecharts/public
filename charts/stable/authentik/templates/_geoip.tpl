{{/* Define the geoip container */}}
{{- define "authentik.geoip" -}}
enabled: true
imageSelector: geoipImage
envFrom:
  - secretRef:
      name: 'geoip-secret'
  - configMapRef:
      name: 'geoip-config'
probes:
  liveness:
    enabled: false
  readiness:
    enabled: false
  startup:
    enabled: false
{{/* TODO: Add healthchecks */}}
{{/* TODO: https://github.com/maxmind/geoipupdate/issues/105 */}}
{{- end -}}
