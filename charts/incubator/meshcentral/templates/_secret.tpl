{{/* Define the secret */}}
{{- define "meshcentral.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $config := .Values.meshcentral }}

{{- $sessionKey := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  {{- $sessionKey = (index .data "session_key") }}
{{- else }}
  {{- $sessionKey = randAlphaNum 32 }}
{{- end }}

{{/* Inject some values */}}
{{- $_ := set $config "$schema" "http://info.meshcentral.com/downloads/meshcentral-config-schema.json" }}
{{- $_ := set $config "__comment__" "This file is generated dynamically at install time, do not attempt to modify it. On next start it will be re-generated" }}

{{- if not (hasKey $config "settings") }}
  {{- $_ := set $config "settings" dict }}
{{- end }}

{{- $_ := set $config.settings "mongoDB" (.Values.mongodb.url.complete | trimAll "\"") }}
{{- $_ := set $config.settings "mongoDbName" .Values.mongodb.mongodbDatabase }}
{{- $_ := set $config.settings "sessionKey" $sessionKey }}
{{- $_ := set $config.settings "port" .Values.service.main.ports.main.port }}

{{/* Force disable some functions that are not appliable in docker */}}
{{- $_ := set $config.settings "selfUpdate" false }}
{{- $_ := set $config.settings "cleanNpmCacheOnUpdate" false }}

{{/* Disallows administrators to update the server from the My Server tab. For ANY domains defined */}}
{{- range $domain := $config.domains }}
  {{- if not (hasKey $domain "myServer") }}
    {{- $_ := set $domain "myServer" dict }}
  {{- end -}}
  {{- $_ := set $domain.myServer "Upgrade" false }}
{{- end }}

{{- $config := (include "prune.underscored.keys" $config) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Store session_key to reuse */}}
  session_key: {{ $sessionKey | b64enc }}
  {{/* The actual config */}}
  config.json: |
{{- toPrettyJson (fromYaml $config) | b64enc | nindent 4 }}
{{- end }}


{{- define "prune.underscored.keys" }}
  {{- $values := . }}
  {{- range $k, $v := $values }}
    {{/* Prune values with empty string, used for SCALE UI mainly */}}
    {{- if eq (kindOf $v) "string" }}
      {{- if not $v }}
        {{- $_ := unset $values $k }}
      {{- end }}
    {{- end }}
    {{- if (hasPrefix "_" $k) }}
      {{- $_ := unset $values $k }}
    {{- else }}
      {{- if eq (kindOf $v) "map" }}
        {{- $v := (include "prune.underscored.keys" $v) }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- toYaml $values }}
{{- end }}
