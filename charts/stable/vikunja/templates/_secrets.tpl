{{/* Define the secrets */}}
{{- define "vikunja.secrets" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $secretStorage := printf "%s-storage-secret" (include "tc.common.names.fullname" .) -}}

{{- $jwtSecret := randAlphaNum 32 -}}
{{- with lookup "v1" "Secret" .Release.Namespace $secretStorage -}}
  {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
{{- end }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretStorage }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  JWT_SECRET: {{ $jwtSecret | b64enc }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  config.yml: |
    service:
      interface: {{ .Values.vikunja.service.interface | quote }}
      JWTSecret: {{ $jwtSecret }}
      jwtttl: {{ .Values.vikunja.service.jwtttl }}
      jwtttllong: {{ .Values.vikunja.service.jwtttllong }}




{{- end -}}
