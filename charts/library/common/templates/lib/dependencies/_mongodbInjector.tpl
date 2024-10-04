{{/*
This template generates a random password and ensures it persists across updates/edits to the chart
*/}}
{{- define "tc.v1.common.dependencies.mongodb.secret" -}}

{{- if .Values.mongodb.enabled -}}
  {{/* Use custom-set password */}}
  {{- $dbPass := .Values.mongodb.password -}}

  {{/* Use custom-set root-password */}}
  {{- $rootPass := .Values.mongodb.rootPassword -}}

  {{/* Prepare data */}}
  {{- $dbhost := printf "%v-%v" .Release.Name "mongodb" -}}
  {{- $portHost := printf "%v:27017" $dbhost -}}
  {{- $jdbc := printf "jdbc:mongodb://%v/%v" $portHost .Values.mongodb.mongodbDatabase -}}
  {{- $url := printf "mongodb://%v:%v@%v/%v" .Values.mongodb.mongodbUsername $dbPass $portHost .Values.mongodb.mongodbDatabase -}}
  {{- $urlssl := printf "%v?ssl=true" $url -}}
  {{- $urltls := printf "%v?tls=true" $url -}}

  {{/* Append some values to mongodb.creds, so apps using the dep, can use them */}}
  {{- $_ := set .Values.mongodb.creds "mongodbPassword" ($dbPass | quote) -}}
  {{- $_ := set .Values.mongodb.creds "mongodbRootPassword" ($rootPass | quote) -}}
  {{- $_ := set .Values.mongodb.creds "plain" ($dbhost | quote) -}}
  {{- $_ := set .Values.mongodb.creds "plainhost" ($dbhost | quote) -}}
  {{- $_ := set .Values.mongodb.creds "plainport" ($portHost | quote) -}}
  {{- $_ := set .Values.mongodb.creds "plainporthost" ($portHost | quote) -}}
  {{- $_ := set .Values.mongodb.creds "complete" ($url | quote) -}}
  {{- $_ := set .Values.mongodb.creds "urlssl" ($urlssl | quote) -}}
  {{- $_ := set .Values.mongodb.creds "urltls" ($urltls | quote) -}}
  {{- $_ := set .Values.mongodb.creds "jdbc" ($jdbc | quote) -}}

{{/* Create the secret (Comment also plays a role on correct formatting) */}}
enabled: true
expandObjectName: false
data:
  mongodb-password: {{ $dbPass }}
  mongodb-root-password: {{ $rootPass }}
  url: {{ $url }}
  urlssl: {{ $urlssl }}
  urltls: {{ $urltls }}
  jdbc: {{ $jdbc }}
  plainhost: {{ $dbhost }}
  plainporthost: {{ $portHost }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.dependencies.mongodb.injector" -}}
  {{- $secret := include "tc.v1.common.dependencies.mongodb.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret (printf "%s-%s" .Release.Name "mongodbcreds") $secret -}}
  {{- end -}}
{{- end -}}
