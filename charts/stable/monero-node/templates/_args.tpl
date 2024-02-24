{{- define "monero.args" -}}
args:
  {{- with .Values.monero.rpcbindip }}
  - --rpc-restricted-bind-ip={{ . }}
  {{- end -}}
  {{- with .Values.monero.rpcbindport }}
  - --rpc-restricted-bind-port={{ . }}
  {{- end -}}
  {{- if .Values.monero.publicnode }}
  - --public-node
  {{- end -}}
  {{- if .Values.monero.noigd }}
  - --no-igd
  {{- end -}}
  {{- if .Values.monero.enablednsblocklist }}
  - --enable-dns-blocklist
  {{- end -}}
  {{- if .Values.monero.pruneblockchain }}
  - --prune-blockchain
  {{- end -}}
{{- end -}}
