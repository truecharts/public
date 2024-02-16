{{/* Returns projected Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.projected" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.projected" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.objectName -}}
    {{- fail "Persistence - Expected non-empty [objectName] on [projected] type" -}}
  {{- end -}}

  {{- $objectName := tpl $objectData.objectName $rootCtx -}}

  {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                  "rootCtx" $rootCtx "objectData" $objectData
                  "name" $objectData.shortName "caller" "projected"
                  "key" "projected")) -}}

  {{- if eq $expandName "true" -}}
    {{- $object := (get $rootCtx.Values.projected $objectName) -}}
    {{- if and (not $object) (not $objectData.optional) -}}
      {{- fail (printf "Persistence - Expected projected [%s] defined in [objectName] to exist" $objectName) -}}
    {{- end -}}

    {{- $objectName = (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $objectName) -}}
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
  projected:
    name: {{ $objectName }}
    {{- with $defMode }}
    defaultMode: {{ . }}
    {{- end }}
    {{- with $objectData.sources }}
    sources:
      {{- range . -}}
        {{- range $k, $v := . -}}
          {{- $allowedSources := list "clusterTrustBundle" "configMap" "downwardAPI" "secret" "serviceAccountToken" -}}
          {{- if not (has $allowedSources $k) -}}
            {{- fail "Persistence - Invalid source [$k] for projected Volume $objectName" -}}
          {{- end -}}
        {{ $k }}:
          {{- tpl (toYaml $v) $rootCtx | nindent 10 }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
{{- end -}}
