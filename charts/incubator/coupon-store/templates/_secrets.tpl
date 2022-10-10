{{/* Define the secrets */}}
{{- define "couponstore.secrets" -}}

{{- $secretName := printf "%s-couponstore-secret" (include "tc.common.names.fullname" .) }}

---
{{- $pg := .Values.postgresql }}

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY_BASE: {{ index .data "SECRET_KEY_BASE" }}
  {{- else }}
  SECRET_KEY_BASE: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  DATABASE_URL: {{ printf "postgres://%v:%v@%v-postgresql:5432/%v" $pg.postgresqlUsername ($pg.postgresqlPassword | trimAll "\"") .Release.Name $pg.postgresqlDatabase  | b64enc }}
{{- end -}}
