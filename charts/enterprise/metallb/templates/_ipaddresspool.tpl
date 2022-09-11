{{- define "metallb.ipAddressPool" -}}

{{ $namespace := .Release.Namespace }}

{{- if .Values.ipAddressPools }}
{{- range .Values.ipAddressPools }}
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: {{ .addressPool.name }}
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
  annotations:
    {{- include "tc.common.annotations" $ | nindent 4 }}
spec:
  addresses:
    {{- range .addressPool.addresses }}
    - {{ . }}
    {{- end }}
  autoAssign: {{ .addressPool.autoAssign | default true }}
  avoidBuggyIPs: {{ .addressPool.avoidBuggyIPs | default false }}
{{- end }}
{{- end }}
{{- end -}}
