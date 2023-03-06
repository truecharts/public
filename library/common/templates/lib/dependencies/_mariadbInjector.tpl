{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.mariadb.secret" -}}
{{- $pghost := printf "%v-%v" .Release.Name "mariadb" }}

{{- if .Values.mariadb.enabled }}
enabled: true
expandObjectName: false
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-mariadbcreds" $basename -}}
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace $fetchname }}
{{- $dbpreviousold := lookup "v1" "Secret" .Release.Namespace "mariadbcreds" }}
{{- $dbPass := "" }}
{{- $rootPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "mariadb-password" ) | b64dec  }}
  {{- $rootPass = ( index $dbprevious.data "mariadb-root-password" ) | b64dec  }}
  mariadb-password: {{ ( index $dbprevious.data "mariadb-password" ) }}
  mariadb-root-password: {{ ( index $dbprevious.data "mariadb-root-password" ) }}
{{- else if $dbpreviousold }}
  {{- $dbPass = ( index $dbpreviousold.data "mariadb-password" ) | b64dec  }}
  {{- $rootPass = ( index $dbpreviousold.data "mariadb-root-password" ) | b64dec  }}
  mariadb-password: {{ ( index $dbpreviousold.data "mariadb-password" ) }}
  mariadb-root-password: {{ ( index $dbpreviousold.data "mariadb-root-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  {{- $rootPass = randAlphaNum 50 }}
  mariadb-password: {{ $dbPass }}
  mariadb-root-password: {{ $rootPass }}
{{- end }}
  url: {{ ( printf "sql://%v:%v@%v-mariadb:3306/%v" .Values.mariadb.mariadbUsername $dbPass .Release.Name .Values.mariadb.mariadbDatabase  ) }}
  urlnossl: {{ ( printf "sql://%v:%v@%v-mariadb:3306/%v?sslmode=disable" .Values.mariadb.mariadbUsername $dbPass .Release.Name .Values.mariadb.mariadbDatabase  ) }}
  plainporthost: {{ ( printf "%v-%v:3306" .Release.Name "mariadb" ) }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "mariadb" ) }}
  jdbc: {{ ( printf "jdbc:sqlserver://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) }}
  jdbc-mysql: {{ ( printf "jdbc:mysql://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) }}
  jdbc-mariadb: {{ ( printf "jdbc:mariadb://%v-mariadb:3306/%v" .Release.Name .Values.mariadb.mariadbDatabase  ) }}
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

{{- define "tc.v1.common.dependencies.mariadb.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.mariadb.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret ( printf "%s-%s" .Release.Name "mariadbcreds" ) $secret -}}
  {{- end -}}
{{- end -}}
