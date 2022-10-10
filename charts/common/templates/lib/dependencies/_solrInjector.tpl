{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.common.dependencies.solr.injector" -}}
{{- $host := printf "%v-%v" .Release.Name "solr" }}

{{- if .Values.solr.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  name: solrcreds
{{- $solrprevious := lookup "v1" "Secret" .Release.Namespace "solrcreds" }}
{{- $solrPass := "" }}
data:
{{- if $solrprevious }}
  {{- $solrPass = ( index $solrprevious.data "solr-password" ) | b64dec  }}
  solr-password: {{ ( index $solrprevious.data "solr-password" ) }}
{{- else }}
  {{- $solrPass = randAlphaNum 50 }}
  solr-password: {{ $solrPass | b64enc | quote }}
{{- end }}
  url: {{ ( printf "http://%v:%v@%v-solr:8983/url/%v" .Values.solr.solrUsername $solrPass .Release.Name .Values.solr.solrCores ) | b64enc | quote }}
  plainhost: {{ ( ( printf "%v-%v" .Release.Name "solr" ) ) | b64enc | quote }}
type: Opaque
{{- $_ := set .Values.solr "solrPassword" ( $solrPass | quote ) }}
{{- $_ := set .Values.solr.url "plain" ( ( printf "%v-%v" .Release.Name "solr" ) | quote ) }}
{{- $_ := set .Values.solr.url "plainhost" ( ( printf "%v-%v" .Release.Name "solr" ) | quote ) }}

{{- end }}
{{- end -}}
