{{/* Define the geoip container */}}
{{- define "authentik.geoip" -}}
image: {{ .Values.geoipImage.repository }}:{{ .Values.geoipImage.tag }}
imagePullPolicy: {{ .Values.geoipImage.pullPolicy }}
securityContext:
  runAsUser: 0
  runAsGroup: 0
  readOnlyRootFilesystem: false
  runAsNonRoot: false
volumeMounts:
  - name: geoip
    mountPath: "/usr/share/GeoIP"
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-geoip-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-geoip-config'
{{/* TODO: Add healthchecks */}}
{{/* TODO: https://github.com/maxmind/geoipupdate/issues/105 */}}
{{- end -}}
