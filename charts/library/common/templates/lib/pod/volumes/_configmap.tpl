{{/* Returns ConfigMap Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.configmap" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.configmap" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.objectName -}}
    {{- fail "Persistence - Expected non-empty [objectName] on [configmap] type" -}}
  {{- end -}}

  {{- $objectName := tpl $objectData.objectName $rootCtx -}}

  {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                  "rootCtx" $rootCtx "objectData" $objectData
                  "name" $objectData.shortName "caller" "ConfigMap"
                  "key" "configmap")) -}}

  {{- if eq $expandName "true" -}}
    {{- $object := (get $rootCtx.Values.configmap $objectName) -}}
    {{- if and (not $object) (not $objectData.optional) -}}
      {{- fail (printf "Persistence - Expected configmap [%s] defined in [objectName] to exist" $objectName) -}}
    {{- end -}}

    {{- $objectName = (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $objectName) -}}
  {{- end -}}

  {{- $optional := false -}}
  {{- if hasKey $objectData "optional" -}}
    {{- if not (kindIs "bool" $objectData.optional) -}}
      {{- fail (printf "Persistence - Expected [optional] to be [bool], but got [%s]" (kindOf $objectData.optional)) -}}
    {{- end -}}
    {{- $optional = $objectData.optional -}}
  {{- end -}}

  {{- $defMode := "" -}}
  {{- if (and $objectData.defaultMode (not (kindIs "string" $objectData.defaultMode))) -}}
    {{- fail (printf "Persistence - Expected [defaultMode] to be [string], but got [%s]" (kindOf $objectData.defaultMode)) -}}
  {{- end -}}

  {{- with $objectData.defaultMode -}}
    {{- $defMode = tpl $objectData.defaultMode $rootCtx -}}
  {{- end -}}

  {{- if and $defMode (not (mustRegexMatch "^[0-9]{4}$" $defMode)) -}}
    {{- fail (printf "Persistence - Expected [defaultMode] to have be in format of [\"0777\"], but got [%q]" $defMode) -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  configMap:
    name: {{ $objectName }}
    {{- with $defMode }}
    defaultMode: {{ . }}
    {{- end }}
    optional: {{ $optional }}
    {{- with $objectData.items }}
    items:
      {{- range . -}}
        {{- if not .key -}}
          {{- fail "Persistence - Expected non-empty [items.key]" -}}
        {{- end -}}
        {{- if not .path -}}
          {{- fail "Persistence - Expected non-empty [items.path]" -}}
        {{- end }}
    - key: {{ tpl .key $rootCtx }}
      path: {{ tpl .path $rootCtx }}
        {{- end -}}
    {{- end -}}
{{- end -}}
