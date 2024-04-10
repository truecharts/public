{{- define "wyoming-whisper.args" -}}
{{- $whisper := .Values.wyoming_whisper -}}
args:
  - --language
  - {{ $whisper.language | quote }}
  {{- if eq $whisper.model "custom" }}
  - --model
  - {{ $whisper.custom_model | quote }}
  {{- else }}
  - --model
  - {{ $whisper.model | quote }}
  {{- end }}
  - --beam-size
  - {{ $whisper.beam_size | quote }}
  - --initial-prompt
  - {{ $whisper.initial_prompt | quote }}
{{- end -}}
