{{/* Define the secrets */}}
{{- define "fireflyiii.secrets" -}}

---
apiVersion: v1
kind: Secret
metadata:
  {{- $dbcredsname := ( printf "%v-%v"  .Release.Name "dbcreds" ) }}
  name: {{ $dbcredsname }}
data:
  {{- if .Release.IsInstall }}
  postgresql-password: {{ randAlphaNum 50 | b64enc | quote }}
  postgresql-postgres-password: {{ randAlphaNum 50 | b64enc | quote }}
  {{ else }}
  # `index` function is necessary because the property name contains a dash.
  # Otherwise (...).data.db_password would have worked too.
  postgresql-password: {{ index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-password" }}
  postgresql-postgres-password: {{ index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" }}
  {{ end }}
  url: {{ ( printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $dbPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  postgresql_host: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque

{{- end -}}
