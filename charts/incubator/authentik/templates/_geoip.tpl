{{/* Define the geoip container */}}
{{- define "authentik.geoip" -}}
image: {{ .Values.geoipImage.repository }}:{{ .Values.geoipImage.tag }}
imagePullPolicy: '{{ .Values.geoipImage.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: true
  runAsNonRoot: true
volumeMounts:
  - name: geoip
    mountPath: "/usr/share/GeoIP"
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-geoip-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-geoip-config'
{{/* TODO: Add healthchecks */}}

{{- end -}}
