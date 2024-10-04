{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.mariadb.secret" -}}

{{- if .Values.mariadb.enabled -}}
  {{/* Use custom-set password */}}
  {{- $dbPass := .Values.mariadb.password -}}

  {{/* Use custom-set root-password */}}
  {{- $rootPass := .Values.mariadb.rootPassword -}}

  {{/* Prepare data */}}
  {{- $dbhost := printf "%v-%v" .Release.Name "mariadb" -}}
  {{- $portHost := printf "%v:3306" $dbhost -}}
  {{- $complete := printf "sql://%v:%v@%v/%v" .Values.mariadb.mariadbUsername $dbPass $portHost .Values.mariadb.mariadbDatabase -}}
  {{- $urlnossl := printf "sql://%v:%v@%v/%v?sslmode=disable" .Values.mariadb.mariadbUsername $dbPass $portHost .Values.mariadb.mariadbDatabase -}}
  {{- $jdbc := printf "jdbc:sqlserver://%v/%v" $portHost .Values.mariadb.mariadbDatabase -}}
  {{- $jdbcMySQL := printf "jdbc:mysql://%v/%v" $portHost .Values.mariadb.mariadbDatabase -}}
  {{- $jdbcMariaDB := printf "jdbc:mariadb://%v/%v" $portHost .Values.mariadb.mariadbDatabase -}}

  {{/* Append some values to mariadb.creds, so apps using the dep, can use them */}}
  {{- $_ := set .Values.mariadb.creds "mariadbPassword" ($dbPass | quote) -}}
  {{- $_ := set .Values.mariadb.creds "mariadbRootPassword" ($rootPass | quote) -}}
  {{- $_ := set .Values.mariadb.creds "plain" ($dbhost | quote) -}}
  {{- $_ := set .Values.mariadb.creds "plainhost" ($dbhost | quote) -}}
  {{- $_ := set .Values.mariadb.creds "plainport" ($portHost | quote) -}}
  {{- $_ := set .Values.mariadb.creds "plainporthost" ($portHost | quote) -}}
  {{- $_ := set .Values.mariadb.creds "complete" ($complete | quote) -}}
  {{- $_ := set .Values.mariadb.creds "urlnossl" ($urlnossl | quote) -}}
  {{- $_ := set .Values.mariadb.creds "jdbc" ($jdbc | quote) -}}
  {{- $_ := set .Values.mariadb.creds "jdbcmysql" ($jdbcMySQL | quote) -}}
  {{- $_ := set .Values.mariadb.creds "jdbcmariadb" ($jdbcMariaDB | quote) -}}

{{/* Create the secret (Comment also plays a role on correct formatting) */}}
enabled: true
expandObjectName: false
data:
  mariadb-password: {{ $dbPass }}
  mariadb-root-password: {{ $rootPass }}
  url: {{ $complete }}
  urlnossl: {{ $urlnossl }}
  plainporthost: {{ $portHost }}
  plainhost: {{ $dbhost }}
  jdbc: {{ $jdbc }}
  jdbc-mysql: {{ $jdbcMySQL }}
  jdbc-mariadb: {{ $jdbcMariaDB }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.dependencies.mariadb.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.mariadb.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret (printf "%s-%s" .Release.Name "mariadbcreds") $secret -}}
  {{- end -}}
{{- end -}}
