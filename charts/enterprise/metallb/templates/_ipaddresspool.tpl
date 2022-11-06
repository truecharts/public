{{- define "metallb.pool" -}}
{{- range .Values.ipAddressPools }}
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: {{ $.Release.Name }}-{{ .name }}
  namespace: metallb-system
spec:
  addresses:
    {{- range .addresses }}
    - {{ . }}
    {{- end }}
  autoAssign: {{ .autoAssign | default true }}
  avoidBuggyIPs: {{ .avoidBuggyIPs | default false }}
{{- end }}
{{- end -}}
