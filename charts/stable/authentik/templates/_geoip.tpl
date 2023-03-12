{{/* Define the geoip container */}}
{{- define "authentik.geoip" -}}
enabled: true
imageSelector: geoipImage
imagePullPolicy: {{ .Values.geoipImage.pullPolicy }}
envFrom:
  - secretRef:
      name: 'geoip-secret'
  - configMapRef:
      name: 'geoip-config'
{{/* TODO: Add healthchecks */}}
{{/* TODO: https://github.com/maxmind/geoipupdate/issues/105 */}}
{{- end -}}
