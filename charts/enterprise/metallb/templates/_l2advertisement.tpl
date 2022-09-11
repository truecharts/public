{{- define "metallb.layer2adv" -}}

{{ $namespace := .Release.Namespace }}

{{- if .Values.L2Advertisements }}
{{- range .Values.L2Advertisements }}
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: {{ .name }}
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
  annotations:
    {{- include "tc.common.annotations" $ | nindent 4 }}
spec:
  ipAddressPools:
  {{- range .addressPools }}
    - {{ . }}
  {{- end }}
  {{- if .nodeSelectors }}
    {{- range .nodeSelectors }}
  nodeSelectors:
    - matchLabels:
        kubernetes.io/hostname: {{ . }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- end -}}
