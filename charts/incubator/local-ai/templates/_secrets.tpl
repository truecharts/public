{{/* Define the secrets */}}
{{- define "localai.secrets" -}}
{{- $secretName := (printf "%s-localai-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $lai := .Values.localai -}}
enabled: true
data:
  ADDRESS: ":{{ .Values.service.main.ports.main.port }}"
  MODELS_PATH: {{ .Values.persistence.models.mountPath }}
  IMAGE_PATH: {{ .Values.persistence.images.mountPath }}
  BUILD_TYPE: {{ $lai.build_type }}
  REBUILD: {{ ternary true false $lai.rebuild }}
  GO_TAGS: {{ $lai.go_tags }}
  CONTEXT_SIZE: {{ $lai.context_size | quote }}
  DEBUG: {{ ternary true false $lai.debug }}
  CORS: {{ ternary true false $lai.cors }}
  CORS_ALLOW_ORIGINS: {{ $lai.cors_allow_origins | quote }}
{{- end }}
