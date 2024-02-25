{{- define "monero.args" -}}
args:
  - --rpc-restricted-bind-ip={{ .Values.monero.rpcbindip }}
  - --rpc-restricted-bind-port={{ .Values.service.rpc.ports.rpc.port }}
  - --public-node
  - --no-igd
  - --enable-dns-blocklist
  - --prune-blockchain
{{- end -}}
