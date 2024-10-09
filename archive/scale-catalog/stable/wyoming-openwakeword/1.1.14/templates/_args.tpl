{{- define "wyoming-openwakeword.args" -}}
{{- $openwakeword := .Values.wyoming_openwakeword -}}
args:
  - --model
  - {{ $openwakeword.model | quote }}
  {{- if $openwakeword.preload_model }}
  - --preload-model
  - {{ $openwakeword.model | quote }}
  {{- end }}
  {{- if $openwakeword.custom_model.path }}
  - --custom-model-dir
  - {{ $openwakeword.custom_model.path | quote }}
  {{- end }}
  {{- if $openwakeword.debug }}
  - --debug
  {{- end }}
  - --threshold
  - {{ $openwakeword.threshold | quote }}
  - --trigger-level
  - {{ $openwakeword.trigger_level | quote }}
{{- end -}}
