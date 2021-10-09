{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "common.dependencies.postgresql.injector" -}}
{{- $pghost := printf "%v-%v" .Release.Name "postgresql" }}
{{- if .Values.postgresql.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: dbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "dbcreds" }}
{{- $dbPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "postgresql-password" ) | b64dec  }}
  postgresql-password: {{ ( index $dbprevious.data "postgresql-password" ) }}
  postgresql-postgres-password: {{ ( index $dbprevious.data "postgresql-postgres-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  postgresql-password: {{ $dbPass | b64enc | quote }}
  postgresql-postgres-password: {{ randAlphaNum 50 | b64enc | quote }}
{{- end }}
  url: {{ ( printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $dbPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.postgresql "postgresqlPassword" ( $dbPass | quote ) }}

{{- end }}
{{- end -}}
