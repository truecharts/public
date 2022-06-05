{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.common.dependencies.postgresql.injector" -}}
{{- $pghost := printf "%v-%v" .Release.Name "postgresql" }}

{{- if .Values.postgresql.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  name: dbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "dbcreds" }}
{{- $dbPass := "" }}
{{- $pgPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "postgresql-password" ) | b64dec  }}
  {{- $pgPass = ( index $dbprevious.data "postgresql-postgres-password" ) | b64dec  }}
  postgresql-password: {{ ( index $dbprevious.data "postgresql-password" ) }}
  postgresql-postgres-password: {{ ( index $dbprevious.data "postgresql-postgres-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  {{- $pgPass = randAlphaNum 50 }}
  postgresql-password: {{ $dbPass | b64enc | quote }}
  postgresql-postgres-password: {{ $pgPass | b64enc | quote }}
{{- end }}
  url: {{ ( printf "postgresql://%v:%v@%v-postgresql:5432/%v" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  url-noql: {{ ( printf "postgres://%v:%v@%v-postgresql:5432/%v" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  urlnossl: {{ ( printf "postgresql://%v:%v@%v-postgresql:5432/%v?sslmode=disable" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  plainporthost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
  jdbc: {{ ( printf "jdbc:postgresql://%v-postgresql:5432/%v" .Release.Name .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.postgresql "postgresqlPassword" ( $dbPass | quote ) }}
{{- $_ := set .Values.postgresql "postgrespassword" ( $pgPass | quote ) }}
{{- $_ := set .Values.postgresql.url "plain" ( ( printf "%v-%v" .Release.Name "postgresql" ) | quote ) }}
{{- $_ := set .Values.postgresql.url "plainhost" ( ( printf "%v-%v" .Release.Name "postgresql" ) | quote ) }}
{{- $_ := set .Values.postgresql.url "plainport" ( ( printf "%v-%v:5432" .Release.Name "postgresql" ) | quote ) }}
{{- $_ := set .Values.postgresql.url "plainporthost" ( ( printf "%v-%v:5432" .Release.Name "postgresql" ) | quote ) }}
{{- $_ := set .Values.postgresql.url "complete" ( ( printf "postgresql://%v:%v@%v-postgresql:5432/%v" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | quote ) }}
{{- $_ := set .Values.postgresql.url "complete-noql" ( ( printf "postgres://%v:%v@%v-postgresql:5432/%v" .Values.postgresql.postgresqlUsername $dbPass .Release.Name .Values.postgresql.postgresqlDatabase  ) | quote ) }}
{{- $_ := set .Values.postgresql.url "jdbc" ( ( printf "jdbc:postgresql://%v-postgresql:5432/%v" .Release.Name .Values.postgresql.postgresqlDatabase  ) | quote ) }}

{{- end }}
{{- end -}}
