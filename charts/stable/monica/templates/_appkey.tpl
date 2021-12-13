{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "monica.appkey" -}}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: appkey
{{- $keyprevious := lookup "v1" "Secret" .Release.Namespace "appkey" }}
{{- $appkey := "" }}
data:
{{- if $keyprevious }}
  {{- $appkey = ( index $keyprevious.data "appkey" ) | b64dec  }}
  appkey: {{ ( index $keyprevious.data "appkey" ) }}
{{- else }}
  {{- $appkey = randAlphaNum 32 | b64enc }}
  appkey: {{ $appkey | b64enc | quote }}
{{- end }}
type: Opaque
{{- end -}}
