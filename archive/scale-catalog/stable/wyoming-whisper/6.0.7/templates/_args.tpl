{{- define "wyoming-whisper.args" -}}
{{- $whisper := .Values.wyoming_whisper -}}
args:
  - --language
  - {{ $whisper.language | quote }}
  - --model
  - {{ ternary $whisper.custom_model $whisper.model (eq $whisper.model "custom") | quote }}
  - --beam-size
  - {{ $whisper.beam_size | quote }}
  - --initial-prompt
  - {{ $whisper.initial_prompt | quote }}
{{- end -}}
