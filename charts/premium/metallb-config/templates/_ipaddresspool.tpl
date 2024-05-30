{{- define "metallb.pool" -}}
{{- range .Values.ipAddressPools }}
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: {{ .name }}
  namespace: {{ $.Values.operatorNamespace }}
spec:
  addresses:
    {{- range .addresses }}
    - {{ . }}
    {{- end }}
  autoAssign: {{ .autoAssign | default true }}
  avoidBuggyIPs: {{ .avoidBuggyIPs | default false }}
{{- end }}
{{- end -}}
