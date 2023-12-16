{{/* Define the secret */}}
{{- define "meshcentral.secret" -}}

{{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $secretName := printf "%s-mesh-secret" $fullname -}}
{{- $secretStoreName := printf "%s-sec-store" $fullname -}}

{{- $config := .Values.meshcentral -}}
{{- $mc_custom := .Values.additional_meshcentral -}}

{{- $isScale := false -}}
{{- if hasKey .Values.global "ixChartContext" -}}
  {{- $isScale = true -}}
{{- else -}}
  {{- $isScale = false -}}
{{- end -}}

{{- if $isScale -}}
  {{- if .Values.additional_meshcentral -}}
    {{- $mc_custom = (include "render.custom.scale.values" $mc_custom) -}}
    {{- $mc_custom_merged := dict -}}
    {{/* We created a new unique section# for each key we parsed */}}
    {{/* And we merge them here, as without it we would have multiple */}}
    {{/* same top level keys */}}
    {{- range $section := (fromYaml $mc_custom) -}}
      {{- $mc_custom_merged = mergeOverwrite $mc_custom_merged $section -}}
    {{- end -}}
    {{- $config = mergeOverwrite $config $mc_custom_merged -}}
  {{- end -}}
{{- end -}}

{{- $sessionKey := "" -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretStoreName) -}}
  {{- $sessionKey = (index .data "session_key") | b64dec -}}
{{- else -}}
  {{- $sessionKey = randAlphaNum 32 -}}
{{- end -}}

{{/* Inject some values */}}
{{- $_ := set $config "$schema" "http://info.meshcentral.com/downloads/meshcentral-config-schema.json" -}}

{{- if not (hasKey $config "settings") -}}
  {{- $_ := set $config "settings" dict -}}
{{- end -}}

{{- $_ := set $config.settings "postgres" dict -}}
{{- $_ := set $config.settings.postgres "database" .Values.cnpg.main.database -}}
{{- $_ := set $config.settings.postgres "user" .Values.cnpg.main.user -}}
{{- $_ := set $config.settings.postgres "host" (.Values.cnpg.main.creds.host | trimAll "\"") -}}
{{- $_ := set $config.settings.postgres "port" 5432 -}}
{{- $_ := set $config.settings.postgres "password" (.Values.cnpg.main.creds.password | trimAll "\"") -}}
{{- $_ := set $config.settings "sessionKey" $sessionKey -}}
{{- $_ := set $config.settings "port" .Values.service.main.ports.main.port -}}

{{/* Force disable some functions that are not appliable in docker */}}
{{- $_ := set $config.settings "selfUpdate" false -}}
{{- $_ := set $config.settings "cleanNpmCacheOnUpdate" false -}}

{{/* Disallows administrators to update the server from the My Server tab. For ANY domains defined */}}
{{- range $domain := $config.domains -}}
  {{- if not (hasKey $domain "myServer") -}}
    {{- $_ := set $domain "myServer" dict -}}
  {{- end -}}
  {{- $_ := set $domain.myServer "Upgrade" false -}}
{{- end -}}

{{- if $isScale -}}
  {{- $config = (include "mergeAndrenameDefaultDomain" $config) -}}
  {{- $config = (include "prune.keys.scale" (fromYaml $config)) -}}
{{- else -}}
  {{- $config = (include "prune.keys" $config) -}}
{{- end }}

secret:
  sec-store:
    enabled: true
    data:
      {{/* Store session_key to reuse */}}
      session_key: {{ $sessionKey }}
  mesh-secret:
    enabled: true
    data:
      {{/* The actual config */}}
      config.json: |
        {{- toPrettyJson (fromYaml $config) | nindent 8 }}
{{- end -}}

{{/* Prunes keys that start with _ */}}
{{- define "prune.keys" -}}
  {{- $values := . -}}
  {{- range $k, $v := $values -}}
    {{- if (hasPrefix "_" $k) -}}
      {{- $_ := unset $values $k -}}
    {{- else -}}
      {{- if eq (kindOf $v) "map" -}}
        {{- $v := (include "prune.keys" $v) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $values -}}
{{- end -}}

{{/* Only on TrueNAS Scale */}}
{{/* Prunes empty lists */}}
{{/* Prunes int and float equal to -99 */}}
{{/* Prunes empty strings (Does not prune empty strings in lists) */}}
{{/* Prunes keys that start with _ */}}
{{/* There are cases you want to pass strings or bools on the same field */}}
{{/* So if eq string, and eq true/false/null convert to the real values */}}
{{- define "prune.keys.scale" -}}
  {{- $values := . -}}
  {{- range $k, $v := $values -}}
      {{- if eq (kindOf $v) "string" -}}
        {{- if not $v -}}
          {{- $_ := unset $values $k -}}
        {{- else if or (eq $v "true") -}}
          {{- $_ := set $values $k true -}}
        {{- else if or (eq $v "false") -}}
          {{- $_ := set $values $k false -}}
        {{- else if or (eq $v "null") -}}
          {{- $_ := set $values $k nil -}} {{/* nil == null on helm */}}
        {{- end -}}
      {{- end -}}
      {{- if or (eq (kindOf $v) "float64") (eq (kindOf $v) "int64") -}}
        {{- if eq (int $v) -99 -}}
          {{- $_ := unset $values $k -}}
        {{- end -}}
      {{- end -}}
      {{- if eq (kindOf $v) "slice" -}}
        {{- if not $v -}}
          {{- $_ := unset $values $k -}}
        {{- end -}}
      {{- end -}}
    {{- if (hasPrefix "_" $k) -}}
      {{- $_ := unset $values $k -}}
    {{- else -}}
      {{- if eq (kindOf $v) "map" -}}
        {{- $v := (include "prune.keys.scale" $v) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $values -}}
{{- end -}}

{{/* Renames tcdefaultdomain variable to "" as this is the key used by MeshCentral */}}
{{/* but SCALE GUI does not handle it well */}}
{{- define "mergeAndrenameDefaultDomain" -}}
  {{- $values := . -}}
  {{- $defaultDomain := index $values.domains "" -}}
  {{- $computedDomain := mergeOverwrite $defaultDomain $values.domains.tcdefaultdomain -}}
  {{- $_ := set $values.domains "" $computedDomain -}}
  {{- $_ := unset $values.domains "tcdefaultdomain" -}}
  {{- toYaml $values -}}
{{- end -}}

{{/* Takes a list of dicts with a value and a  */}}
{{/* key formatted in dot notaion and converts it to yaml */}}
{{- define "render.custom.scale.values" -}}
  {{- $values := . }}
  {{- $section := 1 }}
  {{- range $item := $values }}
    {{- $indent := 2 }}
    {{- printf "section%v" $section | nindent 0 }}:
    {{- $section = (add 1 (int $section)) }}
    {{- range (split "." $item.key) }}
      {{- . | nindent (int $indent) }}:
      {{- $indent = (add 2 (int $indent)) }}
    {{- end }}
    {{- printf " %v" $item.value }}
  {{- end }}
{{- end -}}
