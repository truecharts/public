{{/*
  This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.clickhouse.secret" -}}
{{- if .Values.clickhouse.enabled }}
enabled: true
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-clickhousecreds" $basename -}}
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace $fetchname }}
{{- $dbpreviousold := lookup "v1" "Secret" .Release.Namespace "clickhousecreds" }}
{{- $dbPass := "" }}
{{- $dbIndex := default "0" .Values.redis.redisDatabase }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "redis-password" ) | b64dec  }}
  clickhouse-password: {{ ( index $dbprevious.data "redis-password" ) }}
{{- else if $dbpreviousold }}
  {{- $dbPass = ( index $dbpreviousold.data "redis-password" ) | b64dec  }}
  clickhouse-password: {{ ( index $dbpreviousold.data "redis-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  clickhouse-password: {{ $dbPass | b64enc | quote }}
{{- end }}


{{- $host     := printf              "%v-clickhouse"           .Release.Name }}
{{- $portHost := printf              "%v-clickhouse:8123"      .Release.Name }}
{{- $ping     := printf       "http://%v-clickhouse:8123/ping" .Release.Name }}
{{- $url      := printf "http://%v:%v@%v-clickhouse:8123/%v"   .Values.clickhouse.clickhouseUsername $dbPass .Release.Name .Values.clickhouse.clickhouseDatabase }}
{{- $jdbc     := printf    "jdbc:ch://%v-clickhouse:8123/%v"   .Release.Name }}
  plainhost:           {{ $host | b64enc | quote }}
  plainporthost:       {{ $portHost | b64enc | quote }}
  ping:                {{ $ping | b64enc | quote }}
  url:                 {{ $url | b64enc | quote }}
  jdbc:                {{ $jdbc | b64enc | quote }}

{{- $_ := set .Values.clickhouse     "clickhousePassword" ($dbPass | quote) }}
{{- $_ := set .Values.clickhouse.url "plain"              ($host | quote) }}
{{- $_ := set .Values.clickhouse.url "plainhost"          ($host | quote) }}
{{- $_ := set .Values.clickhouse.url "plainport"          ($portHost | quote) }}
{{- $_ := set .Values.clickhouse.url "plainporthost"      ($portHost | quote) }}
{{- $_ := set .Values.clickhouse.url "ping"               ($ping | quote) }}
{{- $_ := set .Values.clickhouse.url "complete"           ($url | quote) }}
{{- $_ := set .Values.clickhouse.url "jdbc"               ($jdbc | quote) }}

{{- end }}
{{- end -}}

{{- define "tc.v1.common.dependencies.clickhouse.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.clickhouse.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret "clickhousecreds" $secret -}}
  {{- end -}}
{{- end -}}
