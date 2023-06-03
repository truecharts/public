{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.solr.secret" -}}

{{- if .Values.solr.enabled -}}
  {{/* Initialize variables */}}
  {{- $fetchname := printf "%s-solrcreds" .Release.Name -}}
  {{- $solrprevious := lookup "v1" "Secret" .Release.Namespace $fetchname -}}
  {{- $solrpreviousold := lookup "v1" "Secret" .Release.Namespace "solrcreds" -}}
  {{- $solrPass := randAlphaNum 50 -}}

  {{/* If there are previous secrets, fetch values and decrypt them */}}
  {{- if $solrprevious -}}
    {{- $solrPass = (index $solrprevious.data "solr-password") | b64dec -}}
  {{- else if $solrpreviousold -}}
    {{- $solrPass = (index $solrpreviousold.data "solr-password") | b64dec -}}
  {{- end -}}

  {{/* Prepare data */}}
  {{- $dbHost := printf "%v-%v" .Release.Name "solr" -}}
  {{- $portHost := printf "%v:8983" $dbHost -}}
  {{- $url := printf "http://%v:%v@%v/url/%v" .Values.solr.solrUsername $solrPass $portHost .Values.solr.solrCores -}}

  {{/* Append some values to solr.creds, so apps using the dep, can use them */}}
  {{- $_ := set .Values.solr.creds "solrPassword" ($solrPass | quote) -}}
  {{- $_ := set .Values.solr.creds "plain" ($dbHost | quote) -}}
  {{- $_ := set .Values.solr.creds "plainhost" ($dbHost | quote) -}}
  {{- $_ := set .Values.solr.creds "portHost" ($portHost | quote) -}}
  {{- $_ := set .Values.solr.creds "url" ($url | quote) -}}

{{/* Create the secret (Comment also plays a role on correct formatting) */}}
enabled: true
expandObjectName: false
data:
  solr-password: {{ $solrPass }}
  url: {{ $url }}
  plainhost: {{ $dbHost }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.dependencies.solr.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.solr.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret (printf "%s-%s" .Release.Name "solrcreds") $secret -}}
  {{- end -}}
{{- end -}}
