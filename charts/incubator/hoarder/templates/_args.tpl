{{- define "hoarder.args" -}}
args:
  - --no-sandbox
  - --disable-gpu
  - --disable-dev-shm-usage
  - --remote-debugging-address=0.0.0.0
  - --remote-debugging-port=9222
  - --hide-scrollbars
{{- end -}}
