{{- define "lama.args" -}}
args:
  - --host=0.0.0.0
  - --port={{ .Values.service.main.ports.main.port }}
  {{- if eq .Values.workload.main.podSpec.containers.main.imageSelector "image" }}
  - --device=cpu
    {{- if .Values.lamacleaner.sd_cpu_text_encoder }}
  - --sd-cpu-textencoder
    {{- end }}
  {{- else if eq .Values.workload.main.podSpec.containers.main.imageSelector "gpuImage" }}
  - --device=cuda
  {{- end }}
  {{- with .Values.lamacleaner.model }}
  - --model={{ . }}
  {{- end }}
  {{- if .Values.lamacleaner.sd_run_local }}
  - --sd-run-local
  {{- else if .Values.lamacleaner.hf_access_token  }}
  - --hf_access_token={{ .Values.lamacleaner.hf_access_token }}
  {{- end }}
  {{- if .Values.lamacleaner.sd_enable_xformers }}
  - --sd-enable-xformers
  {{- end }}
  {{- if .Values.lamacleaner.sd_disable_nsfw }}
  - --sd-disable-nsfw
  {{- end }}
  {{- with .Values.lamacleaner.input }}
  - --input={{ . }}
  {{- end }}
  {{- if .Values.lamacleaner.debug }}
  - --debug
  {{- end }}
{{- end -}}
