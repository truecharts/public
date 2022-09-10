{{- define "metallb.ipAddressPool" -}}

{{ $namespace := .Release.Namespace }}

{{- if .Values.metallb.ipAddressPools }}
{{- range .Values.metallb.ipAddressPools }}
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: {{ .addressPool.name }}
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
  annotations:
    meta.helm.sh/release-namespace: {{ $namespace }}
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
