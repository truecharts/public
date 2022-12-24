{{/* Define the secret */}}
{{- define "briefkasten.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  NEXTAUTH_SECRET: {{ index .data "NEXTAUTH_SECRET" }}
  {{- else }}
  NEXTAUTH_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  DATABASE_URL: {{ get .Values.postgresql.url "complete" | trimAll "\"" | b64enc }}
  {{- with .Values.briefkasten.github.id }}
  GITHUB_ID: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.briefkasten.github.secret }}
  GITHUB_SECRET: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.briefkasten.google.id }}
  GOOGLE_ID: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.briefkasten.google.secret }}
  GOOGLE_SECRET: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.briefkasten.supabase.key }}
  SUPABASE_KEY: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.briefkasten.supabase.bucket_id }}
  SUPABASE_BUCKET_ID: {{ . | b64enc }}
  {{- end }}
{{- end }}
