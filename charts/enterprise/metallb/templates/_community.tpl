{{- define "metallb.community" -}}

{{- if .Values.Communities }}
apiVersion: metallb.io/v1beta1
kind: Community
metadata:
  name: communities
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
  annotations:
    {{- include "tc.common.annotations" $ | nindent 4 }}
spec:
  communities:
  {{- range .Values.metallb.Communities }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
{{- end }}

{{- end -}}
