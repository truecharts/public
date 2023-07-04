{{- define "openbooks.args" -}}
{{- $openbooks := .Values.openbooks -}}
args:
  - --port
  - {{ .Values.service.main.ports.main.port | quote }}
  - --name
  - {{ $openbooks.user_name }}
  - --searchbot
  - {{ $openbooks.search }}
  {{- if $openbooks.tls }}
  - --tls
  {{- end -}}
  {{- if $openbooks.log }}
  - --log
  {{- end -}}
  {{- if $openbooks.debug }}
  - --debug
  {{- end -}}
  {{- if $openbooks.persist }}
  - --persist
  {{- end -}}
  {{- if $openbooks.no_browser_downloads }}
  - --no-browser-downloads
  {{- end -}}
{{- end -}}
