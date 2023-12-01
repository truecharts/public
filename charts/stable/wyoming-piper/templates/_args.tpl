{{- define "wyoming-piper.args" -}}
{{- $piper := .Values.wyoming_piper -}}
args:
  - --voice
  - {{- with $piper.custom_voice }}
  - {{ $piper.custom_voice }}
  {{- else }}
  - "{{ $piper.voice }}"
  {{- end }}
  - --speaker
  - "{{ $piper.speaker }}"
  - --length-scale
  - "{{ $piper.length_scale }}"
  - --noise-scale
  - "{{ $piper.noise_scale }}"
  - --noise-w
  - "{{ $piper.noise_w }}"
  - --max-piper-procs
  - "{{ $piper.max_piper_procs }}"

  
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
