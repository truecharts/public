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
{{- end -}}
