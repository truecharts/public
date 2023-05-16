{{- define "immich.wait" -}}
{{- $path := .path | default "" }}
{{- $variable := .variable }}
enabled: true
type: init
imageSelector: alpineImage
envFrom:
  - configMapRef:
      name: common-config
command:
  - /bin/ash
  - -c
  - |
    echo "Pinging [${{ $variable }}/{{ $path }}] until it is ready..."
    until wget --spider --quiet "${{ $variable }}/{{ $path }}"; do
      echo "Waiting for [${{ $variable }}/{{ $path }}] to be ready..."
      sleep 2
    done
    echo "URL [${{ $variable }}/{{ $path }}] is ready!"
{{- end -}}
