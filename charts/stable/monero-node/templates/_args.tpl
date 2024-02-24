{{- define "monero.args" -}}
args:
  - --rpc-restricted-bind-ip={{ .Values.monero.rpcbindip }}
  - --rpc-restricted-bind-port={{ .Values.service.rpc.ports.rpc.port }}
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
