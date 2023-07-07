{{/* Define the secret */}}
{{- define "localai.secret" -}}
{{- $lai := .Values.localai -}}
{{- range $item := $lai.galleries }}
  {{- $names = mustAppend $domains $item.name }}
  {{- $urls = mustAppend $records $item.url }}
{{- end }}
enabled: true
data:
  BUILD_TYPE: {{ $lai.build_type }}
  REBUILD: {{ $lai.rebuild }}
  GO_TAGS: {{ $lai.go_tags }}
  GALLERIES: |
    [
      {
        "name": "model-gallery",
        "url":"github:go-skynet/model-gallery/index.yaml"
      }
    ]
  CONTEXT_SIZE: {{ $lai.context_size }}
  DEBUG: {{ $lai.debug }}
  CORS: {{ $lai.cors }}
  CORS_ALLOW_ORIGINS: {{ $lai.cors_allow_origins | quote }}
{{- end }}
