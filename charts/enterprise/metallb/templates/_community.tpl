{{- define "metallb.comm" -}}
{{- if .Values.Communities }}
---
apiVersion: metallb.io/v1beta1
kind: Community
metadata:
  name: {{ $.Release.Name }}-communities
  namespace: metallb-system
spec:
  communities:
  {{- range .Values.Communities }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
{{- end }}
{{- end -}}
