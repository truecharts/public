{{- define "metallb.l2adv" -}}
{{- range .Values.L2Advertisements }}
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: {{ .name }}
  namespace: {{ $.Values.operatorNamespace }}
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
{{- end -}}
