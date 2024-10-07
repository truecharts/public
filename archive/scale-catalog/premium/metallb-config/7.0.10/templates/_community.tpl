{{- define "metallb.comm" -}}
{{- if .Values.Communities }}
---
apiVersion: metallb.io/v1beta1
kind: Community
metadata:
  name: communities
  namespace: {{ $.Values.operatorNamespace }}
spec:
  communities:
  {{- range .Values.Communities }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
{{- end }}
{{- end -}}
