{{/* Define the secrets */}}
{{- define "localai.secrets" -}}
{{- $secretName := (printf "%s-localai-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $lai := .Values.localai -}}
enabled: true
data:
  ADDRESS: ":{{ .Values.service.main.ports.main.port }}"
  MODELS_PATH: "/models"
  IMAGE_PATH: "/images"
  BUILD_TYPE: {{ $lai.build_type }}
  REBUILD: {{ $lai.rebuild }}
  GO_TAGS: {{ $lai.go_tags }}
  CONTEXT_SIZE: {{ $lai.context_size | quote }}
  DEBUG: {{ $lai.debug }}
  CORS: {{ $lai.cors }}
  CORS_ALLOW_ORIGINS: {{ $lai.cors_allow_origins | quote }}
{{- end }}
