{{- define "metallb.bgpadv" -}}
{{- range .Values.BGPAdvertisements }}
---
apiVersion: metallb.io/v1beta1
kind: BGPAdvertisement
metadata:
  name: {{ .name }}
  namespace: metallb-system
spec:
  ipAddressPools:
  {{- range .addressPools }}
    - {{ . }}
  {{- end }}
  {{- with .aggregationLength }}
  aggregationLength: {{ . | int }}
  {{- end }}
  {{- with .localpref }}
  localpref: {{ . | int }}
  {{- end }}
  {{- if .communities }}
  communities:
    {{- range .communities }}
    - {{ . }}
    {{- end }}
  {{- end }}
  {{- if .peers }}
  peers:
    {{- range .peers }}
    - {{ . }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end -}}
