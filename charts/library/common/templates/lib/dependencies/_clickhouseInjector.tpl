{{/*
  This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.clickhouse.secret" -}}

{{- if .Values.clickhouse.enabled -}}
  {{/* Use with custom-set password */}}
  {{- $dbPass := .Values.clickhouse.password -}}

  {{/* Prepare data */}}
  {{- $dbHost := printf "%v-%v" .Release.Name "clickhouse" -}}
  {{- $portHost := printf "%v:8123" $dbHost -}}
  {{- $ping := printf "http://%v/ping" $portHost -}}
  {{- $url := printf "http://%v:%v@%v/%v" .Values.clickhouse.clickhouseUsername $dbPass $portHost .Values.clickhouse.clickhouseDatabase -}}
  {{- $jdbc := printf "jdbc:ch://%v/%v" $portHost -}}

  {{/* Append some values to clickhouse.creds, so apps using the dep, can use them */}}
  {{- $_ := set .Values.clickhouse.creds "plain" ($dbHost | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "plainhost" ($dbHost | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "clickhousePassword" ($dbPass | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "plainport" ($portHost | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "plainporthost" ($portHost | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "ping" ($ping | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "complete" ($url | quote) -}}
  {{- $_ := set .Values.clickhouse.creds "jdbc" ($jdbc | quote) -}}

{{/* Create the secret (Comment also plays a role on correct formatting) */}}
enabled: true
expandObjectName: false
data:
  clickhouse-password: {{ $dbPass }}
  plainhost: {{ $dbHost }}
  plainporthost: {{ $portHost }}
  ping: {{ $ping }}
  url: {{ $url }}
  jdbc: {{ $jdbc }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.dependencies.clickhouse.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.clickhouse.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret ( printf "%s-%s" .Release.Name "clickhousecreds" ) $secret -}}
  {{- end -}}
{{- end -}}
