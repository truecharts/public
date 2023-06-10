{{/* Define the geoip container */}}
{{- define "authentik.geoip.container" -}}
enabled: true
primary: false
imageSelector: geoipImage
securityContext:
  runAsUser: 0
  runAsGroup: 0
envFrom:
  - secretRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-geoip-secret'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-geoip-config'
{{/* TODO: Add healthchecks */}}
{{/* TODO: https://github.com/maxmind/geoipupdate/issues/105 */}}
probes:
  readiness:
    enabled: false
  liveness:
    enabled: false
  startup:
    enabled: false
{{- end -}}
