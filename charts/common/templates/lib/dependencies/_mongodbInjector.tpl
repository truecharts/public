{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.common.dependencies.mongodb.injector" -}}
{{- $pghost := printf "%v-%v" .Release.Name "mongodb" }}

{{- if .Values.mongodb.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  name: mongodbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "mongodbcreds" }}
{{- $dbPass := "" }}
{{- $rootPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "mongodb-password" ) | b64dec  }}
  {{- $rootPass = ( index $dbprevious.data "mongodb-root-password" ) | b64dec  }}
  mongodb-password: {{ ( index $dbprevious.data "mongodb-password" ) }}
  mongodb-root-password: {{ ( index $dbprevious.data "mongodb-root-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  {{- $rootPass = randAlphaNum 50 }}
  mongodb-password: {{ $dbPass | b64enc | quote }}
  mongodb-root-password: {{ $rootPass | b64enc | quote }}
{{- end }}
  url: {{ ( printf "mongodb://%v:%v@%v-mongodb:27017/%v" .Values.mongodb.mongodbUsername $dbPass .Release.Name .Values.mongodb.mongodbDatabase  ) | b64enc | quote }}
  urlssl: {{ ( printf "mongodb://%v:%v@%v-mongodb:27017/%v?ssl=true" .Values.mongodb.mongodbUsername $dbPass .Release.Name .Values.mongodb.mongodbDatabase  ) | b64enc | quote }}
  urltls: {{ ( printf "mongodb://%v:%v@%v-mongodb:27017/%v?tls=true" .Values.mongodb.mongodbUsername $dbPass .Release.Name .Values.mongodb.mongodbDatabase  ) | b64enc | quote }}
  jdbc: {{ ( printf "jdbc:mongodb://%v-mongodb:27017/%v" .Release.Name .Values.mongodb.mongodbDatabase  ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "mongodb" ) | b64enc | quote }}
  plainporthost: {{ ( printf "%v-%v:27017" .Release.Name "mongodb" ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.mongodb "mongodbPassword" ( $dbPass | quote ) }}
{{- $_ := set .Values.mongodb "mongodbRootPassword" ( $rootPass | quote ) }}
{{- $_ := set .Values.mongodb.url "plain" ( ( printf "%v-%v" .Release.Name "mongodb" ) | quote ) }}
{{- $_ := set .Values.mongodb.url "plainhost" ( ( printf "%v-%v" .Release.Name "mongodb" ) | quote ) }}
{{- $_ := set .Values.mongodb.url "plainport" ( ( printf "%v-%v:27017" .Release.Name "mongodb" ) | quote ) }}
{{- $_ := set .Values.mongodb.url "plainporthost" ( ( printf "%v-%v:27017" .Release.Name "mongodb" ) | quote ) }}
{{- $_ := set .Values.mongodb.url "complete" ( ( printf "mongodb://%v:%v@%v-mongodb:27017/%v" .Values.mongodb.mongodbUsername $dbPass .Release.Name .Values.mongodb.mongodbDatabase  ) | quote ) }}
{{- $_ := set .Values.mongodb.url "jdbc" ( ( printf "jdbc:mongodb://%v-mongodb:27017/%v" .Release.Name .Values.mongodb.mongodbDatabase  ) | quote ) }}

{{- end }}
{{- end -}}
