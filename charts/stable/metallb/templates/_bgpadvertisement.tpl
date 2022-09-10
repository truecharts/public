{{- define "metallb.bgpadv" -}}

{{- if .Values.metallb.BGPAdvertisements }}
{{- range .Values.metallb.BGPAdvertisements }}
apiVersion: metallb.io/v1beta1
kind: BGPAdvertisement
metadata:
  name: {{ .name }}
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
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
{{- end }}

{{- end -}}
