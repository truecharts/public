{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "anonaddy.appkey" -}}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  name: appkey
{{- $keyprevious := lookup "v1" "Secret" .Release.Namespace "appkey" }}
{{- $appkey := "" }}
{{- $secret := "" }}
data:
{{- if $keyprevious }}
  {{- $appkey = ( index $keyprevious.data "appkey" ) }}
  {{- $secret = ( index $keyprevious.data "secret" ) }}
  appkey: {{ ( index $keyprevious.data "appkey" ) }}
  secret: {{ ( index $keyprevious.data "secret" ) }}
{{- else }}
  {{- $appkey = randAlphaNum 32 }}
  {{- $secret = randAlphaNum 32 }}
  appkey: {{ $appkey | b64enc }}
  secret: {{ $secret | b64enc }}
{{- end }}
{{- end -}}
