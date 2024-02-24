{{- define "monero.args" -}}
args:
  {{- with .Values.monero.rpc-bind-ip }}
  - --rpc-restricted-bind-ip={{ . }}
  {{- end -}}
  {{- with .Values.monero.rpc-bind-port }}
  - --rpc-restricted-bind-port={{ . }}
  {{- end -}}
  {{- if .Values.monero.public-node }}
  - --public-node
  {{- end -}}
  {{- if .Values.monero.no-igd }}
  - --no-igd
  {{- end -}}
  {{- if .Values.monero.enable-dns-blocklist }}
  - --enable-dns-blocklist
  {{- end -}}
  {{- if .Values.monero.prune-blockchain }}
  - --prune-blockchain
  {{- end -}}
{{- end -}}
