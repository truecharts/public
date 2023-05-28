{{/*
This template generates a random appkey and ensures it persists across updates/edits to the chart
*/}}
{{- define "monica.appkey" -}}
enabled: true
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-appkey" $basename -}}
{{- $keyprevious := lookup "v1" "Secret" .Release.Namespace $fetchname }}
{{- $appkey := "" }}
data:
  {{- if $keyprevious }}
  appkey: {{ ( index $keyprevious.data "appkey" ) | b64dec }}
  {{- else }}
  {{- $appkey = randAlphaNum 32 }}
  appkey: {{ $appkey }}
  {{- end }}
{{- end -}}
