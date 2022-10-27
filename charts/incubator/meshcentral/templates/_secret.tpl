{{/* Define the secret */}}
{{- define "meshcentral.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $config := .Values.meshcentral }}

{{- $isScale := false }}
{{- if hasKey .Values.global "isSCALE" }}
  {{- $isScale = .Values.global.isSCALE }}
{{- else }}
  {{- $isScale = false }}
{{- end }}

{{- $sessionKey := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  {{- $sessionKey = (index .data "session_key") }}
{{- else }}
  {{- $sessionKey = randAlphaNum 32 }}
{{- end }}

{{/* Inject some values */}}
{{- $_ := set $config "$schema" "http://info.meshcentral.com/downloads/meshcentral-config-schema.json" }}

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

{{- if $isScale }}
  {{- $config = (include "prune.keys.scale" $config) }}
{{- else }}
  {{- $config = (include "prune.keys" $config) }}
{{- end }}
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
  trigger_redeploy: {{ randAlpha 5 }}
  {{/* The actual config */}}
  config.json: |
    {{- toPrettyJson (fromYaml $config) | b64enc | nindent 4 }}
{{- end }}

{{/* Prunes keys that start with _ */}}
{{- define "prune.keys" }}
  {{- $values := . }}
  {{- range $k, $v := $values }}
    {{- if (hasPrefix "_" $k) }}
      {{- $_ := unset $values $k }}
    {{- else }}
      {{- if eq (kindOf $v) "map" }}
        {{- $v := (include "prune.keys" $v) }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- toYaml $values }}
{{- end }}

{{/* Only on TrueNAS Scale */}}
{{/* Prunes empty lists */}}
{{/* Prunes int and float equal to -99 */}}
{{/* Prunes empty strings (Does not prune empty strings in lists) */}}
{{/* Prunes keys that start with _ */}}
{{/* Renames tcdefaultdomain variable to "" as this is the key used by MeshCentral */}}
{{/* but SCALE GUI does not handle it well */}}
{{- define "prune.keys.scale" }}
  {{- $values := . }}
  {{- if (hasKey $values "domains") }}
    {{- if (hasKey $values.domains "tcdefaultdomain") }}
      {{- $defaultDomain := $values.domains.tcdefaultdomain }}
      {{- $_ := set $values.domains "" $defaultDomain }}
      {{- $_ := unset $values.domains "tcdefaultdomain" }}
    {{- end }}
  {{- end }}
  {{- range $k, $v := $values }}
      {{- if eq (kindOf $v) "string" }}
        {{- if not $v }}
          {{- $_ := unset $values $k }}
        {{- end }}
      {{- end }}
      {{- if or (eq (kindOf $v) "float64") (eq (kindOf $v) "int64") }}
        {{- if eq (int $v) -99 }}
          {{- $_ := unset $values $k }}
        {{- end }}
      {{- end }}
      {{- if eq (kindOf $v) "slice" }}
        {{- if not $v }}
          {{- $_ := unset $values $k }}
        {{- end }}
      {{- end }}
    {{- if (hasPrefix "_" $k) }}
      {{- $_ := unset $values $k }}
    {{- else }}
      {{- if eq (kindOf $v) "map" }}
        {{- $v := (include "prune.keys.scale" $v) }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- toYaml $values }}
{{- end }}
