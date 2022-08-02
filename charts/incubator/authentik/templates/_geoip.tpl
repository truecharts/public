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
env:
  - name: GEOIPUPDATE_EDITION_IDS
    value: "{{ .Values.geoip.edition }}"
  - name: GEOIPUPDATE_FREQUENCY
    value: "{{ .Values.geoip.frequency }}"
  - name: GEOIPUPDATE_HOST
    value: "{{ .Values.geoip.host_server }}"
  - name: GEOIPUPDATE_PRESERVE_FILE_TIMES
    value: '{{ ternary "1" "0" .Values.geoip.preserve_file_times }}'
  - name: GEOIPUPDATE_VERBOSE
    value: "{{ .Values.geoip.verbose }}"
{{/* TODO: Add healthchecks */}}

{{- end -}}
