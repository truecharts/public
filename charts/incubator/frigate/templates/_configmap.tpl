{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}

{{- $configName := printf "%s-frigate-config" (include "tc.common.names.fullname" .) }}

{{- $config := .Values.frigate -}}
{{- $frigate_custom := .Values.additional_frigate -}}

{{/* Determine if running in SCALE */}}
{{- $isScale := false }}
{{- if hasKey .Values.global "isSCALE" }}
  {{- $isScale = .Values.global.isSCALE }}
{{- else }}
  {{- $isScale = false }}
{{- end }}

{{/* Parse additional custom values */}}
{{- if $isScale }}
  {{- if $frigate_custom }}
    {{- $frigate_custom = (include "render.custom.scale.values" $frigate_custom) }}
    {{- $frigate_custom_merged := dict }}
    {{/* We created a new unique section# for each key we parsed */}}
    {{/* And we merge them here, because without it we would have multiple */}}
    {{/* same top level keys */}}
    {{- range $section := (fromYaml $frigate_custom) }}
      {{- $frigate_custom_merged = mergeOverwrite $frigate_custom_merged $section }}
    {{- end }}
    {{- $config = mergeOverwrite $config $frigate_custom_merged }}
  {{- end }}
{{- end }}

{{/* Inject some values */}}
{{- if not (hasKey $config "database") }}
  {{- $_ := set $config "database" dict }}
{{- end }}
{{- $_ := set $config.database "path" "/media/frigate/frigate.db" }}

{{/* Prune keys that's not needed */}}
{{- if $isScale }}
  {{- $config = (include "prune.keys.scale" $config) }}
{{- else }}
  {{- $config = (include "prune.keys" $config) }}
{{- end }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  config.yml:
    {{- tpl $config $ | nindent 4 }}
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
{{- define "prune.keys.scale" }}
  {{- $values := . }}
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

{{/* Takes a list of dicts with a value and a key */}}
{{/* formatted in dot notaion and converts it to yaml */}}
{{- define "render.custom.scale.values" }}
  {{- $values := . }}
  {{- $section := 1 }}
  {{- range $item := $values }}
    {{- $indent := 2 }}
    {{- printf "section%v" $section | nindent 0 }}:
    {{- $section = (add 1 (int $section)) }}
    {{- range (split "." $item.key) }}
      {{- . | nindent (int $indent) }}:
      {{- $indent = (add 2 (int $indent)) }}
    {{- end -}}
    {{- printf " %v" $item.value }}
  {{- end }}
{{- end }}
