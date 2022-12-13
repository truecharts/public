{{/* Define the secret */}}
{{- define "euterpe.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $secretStorageName := printf "%s-storage-secret" (include "tc.common.names.fullname" .) }}

{{- $secretKey := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretStorageName) }}
  {{- $secretKey = (index .data "secret") | b64dec }}
{{- else }}
  {{- $secretKey = randAlphaNum 32 | b64enc }}
{{- end }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  config.json: |
    {
      "listen": {{ printf ":%v" .Values.service.main.ports.main.port | quote }},
      "ssl": false,

      "basic_authenticate": {{ .Values.euterpe.basic_authenticate }},
      "authentication": {
          {{- with .Values.euterpe.authentication.user }}
          "user": {{ . | quote }},
          {{- end }}
          {{- with .Values.euterpe.authentication.password }}
          "password": {{ . | quote }},
          {{- end }}
          "secret": {{ $secretKey | quote }}
      },

      {{- $libraries := .Values.euterpe.libraries -}}
      {{- $libraries = append $libraries .Values.persistence.music.mountPath }}

      "libraries": [
        {{- range initial $libraries }}
          {{ . | quote }},
        {{- end }}
          {{ last $libraries | quote }}
      ],

      "library_scan": {
          "initial_wait_duration": {{ .Values.euterpe.library_scan.initial_wait_duration | quote }},
          "files_per_operation": {{ .Values.euterpe.library_scan.files_per_operation }},
          "sleep_after_operation": {{ .Values.euterpe.library_scan.sleep_after_operation | quote }}
      },

      "download_artwork": {{ .Values.euterpe.discogs.download_artwork }},

      {{- with .Values.euterpe.discogs.discogs_auth_token }}
      "discogs_auth_token": {{ . | quote }},
      {{- end }}

      "gzip": {{ .Values.euterpe.danger_zone.gzip }},
      "log_file": {{ .Values.euterpe.danger_zone.log_file | quote }},
      "sqlite_database": {{ .Values.euterpe.danger_zone.sqlite_database | quote }},
      "read_timeout": {{ .Values.euterpe.danger_zone.read_timeout }},
      "write_timeout": {{ .Values.euterpe.danger_zone.write_timeout }},
      "max_header_bytes": {{ .Values.euterpe.danger_zone.max_header_bytes | int }}
    }
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretStorageName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Store secretKey to reuse */}}
  secret: {{ $secretKey | b64enc }}
{{- end }}
