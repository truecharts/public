{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.common.dependencies.mariadb.injector" -}}
{{- $pghost := printf "%v-%v" .Release.Name "mariadb" }}

{{- if .Values.mariadb.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  name: mariadbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "mariadbcreds" }}
{{- $dbPass := "" }}
{{- $rootPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "mariadb-password" ) | b64dec  }}
  {{- $rootPass = ( index $dbprevious.data "mariadb-root-password" ) | b64dec  }}
  mariadb-password: {{ ( index $dbprevious.data "mariadb-password" ) }}
  mariadb-root-password: {{ ( index $dbprevious.data "mariadb-root-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  {{- $rootPass = randAlphaNum 50 }}
  mariadb-password: {{ $dbPass | b64enc | quote }}
  mariadb-root-password: {{ $rootPass | b64enc | quote }}
{{- end }}
  url: {{ ( printf "sql://%v:%v@%v-mariadb:3306/%v" .Values.mariadb.mariadbUsername $dbPass .Release.Name .Values.mariadb.mariadbDatabase  ) | b64enc | quote }}
  urlnossl: {{ ( printf "sql://%v:%v@%v-mariadb:3306/%v?sslmode=disable" .Values.mariadb.mariadbUsername $dbPass .Release.Name .Values.mariadb.mariadbDatabase  ) | b64enc | quote }}
  plainporthost: {{ ( printf "%v-%v:3306" .Release.Name "mariadb" ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "mariadb" ) | b64enc | quote }}
  jdbc: {{ ( printf "jdbc:sqlserver://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) | b64enc | quote }}
  jdbc-mysql: {{ ( printf "jdbc:mysql://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) | b64enc | quote }}
  jdbc-mariadb: {{ ( printf "jdbc:mariadb://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.mariadb "mariadbPassword" ( $dbPass | quote ) }}
{{- $_ := set .Values.mariadb "mariadbRootPassword" ( $rootPass | quote ) }}
{{- $_ := set .Values.mariadb.url "plain" ( ( printf "%v-%v" .Release.Name "mariadb" ) | quote ) }}
{{- $_ := set .Values.mariadb.url "plainhost" ( ( printf "%v-%v" .Release.Name "mariadb" ) | quote ) }}
{{- $_ := set .Values.mariadb.url "plainport" ( ( printf "%v-%v:3306" .Release.Name "mariadb" ) | quote ) }}
{{- $_ := set .Values.mariadb.url "plainporthost" ( ( printf "%v-%v:3306" .Release.Name "mariadb" ) | quote ) }}
{{- $_ := set .Values.mariadb.url "complete" ( ( printf "sql://%v:%v@%v-mariadb:3306/%v" .Values.mariadb.mariadbUsername $dbPass .Release.Name .Values.mariadb.mariadbDatabase  ) | quote ) }}
{{- $_ := set .Values.mariadb.url "jdbc" ( ( printf "jdbc:sqlserver://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) | quote ) }}

{{- end }}
{{- end -}}
