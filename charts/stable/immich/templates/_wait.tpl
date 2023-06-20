{{- define "immich.wait" -}}
{{- $url := .url }}
enabled: true
type: init
imageSelector: alpineImage
command:
  - /bin/ash
  - -c
  - |
    echo "Pinging [{{ $url }}] until it is ready..."
    until wget --spider --quiet "{{ $url }}"; do
      echo "Waiting for [{{ $url }}] to be ready..."
      sleep 2
    done
    echo "URL [{{ $url }}] is ready!"
{{- end -}}
