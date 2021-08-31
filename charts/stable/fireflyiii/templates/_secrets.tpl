{{/* Define the secrets */}}
{{- define "fireflyiii.secrets" -}}

---
apiVersion: v1
kind: Secret
metadata:
  {{- $dbcredsname := ( printf "%v-%v"  .Release.Name "dbcreds" ) }}
  name: {{ $dbcredsname }}
data:
  {{- $dbPass := "" }}
  {{ $rootPass := "" }}
  {{ $urlPass := "" }}

  {{- if .Release.IsInstall }}
  {{ $dbPass = ( randAlphaNum 50 | b64enc | quote )  }}
  {{ $rootPass = ( randAlphaNum 50 | b64enc | quote )  }}
  {{ $urlPass = $dbPass }}
  {{ else }}
  # `index` function is necessary because the property name contains a dash.
  # Otherwise (...).data.db_password would have worked too.
  {{ $dbPass = ( index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" ) }}
  {{ $rootPass = ( index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" ) }}
  {{ $urlPass = ( ( index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" ) | b64dec | quote ) }}
  {{ end }}

  postgresql-password: {{ $dbPass }}
  postgresql-postgres-password: {{ $rootPass }}
  url: {{ ( printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $urlPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  postgresql_host: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque

{{- end -}}
