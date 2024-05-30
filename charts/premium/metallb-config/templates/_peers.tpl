{{- define "metallb.peers" -}}
{{- range .Values.Peers }}
---
apiVersion: metallb.io/v1beta2
kind: BGPPeer
metadata:
  name: {{ .name }}
  namespace: {{ $.Values.operatorNamespace }}
spec:
  {{- with .password }}
  password: {{ . }}
  {{- end }}
  {{- with .routerID }}
  routerID: {{ . }}
  {{- end }}
  {{- with .bfdProfile }}
  bfdProfile: {{ . }}
  {{- end }}
  {{- with .ebgpMultiHop }}
  ebgpMultiHop: {{ . }}
  {{- end }}
  {{- with .holdTime }}
  holdTime: {{ . }}
  {{- end }}
  {{- with .keepaliveTime }}
  keepaliveTime: {{ . }}
  {{- end }}
  {{- with .myASN }}
  myASN: {{ . }}
  {{- end }}
  {{- with .peerASN }}
  peerASN: {{ . | int }}
  {{- end }}
  {{- with .peerAddress }}
  peerAddress: {{ . }}
  {{- end }}
  {{- with .peerPort }}
  peerPort: {{ . | int }}
  {{- end }}
  {{- with .sourceAddress }}
  sourceAddress: {{ . }}
  {{- end }}
  {{- if .nodeSelectors }}
  nodeSelectors:
  {{- range .nodeSelectors }}
    - matchLabels:
        kubernetes.io/hostname: {{ . }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end -}}
