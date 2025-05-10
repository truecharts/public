{{/* networkpolicy Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.networkpolicy" $ -}}
*/}}

{{- define "tc.v1.common.spawner.networkpolicy" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $networkpolicy := .Values.networkpolicy -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $networkpolicy
                    "name" $name "caller" "networkpolicy"
                    "key" "networkpolicy")) -}}

    {{- if ne $enabled "true" -}}{{- continue -}}{{- end -}}

    {{/* Create a copy of the configmap */}}
    {{- $objectData := (mustDeepCopy $networkpolicy) -}}
    {{- $namespace := (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $ "objectData" $networkpolicy "caller" "networkpolicy")) -}}

    {{/* Init object name */}}
    {{- $objectName := $name -}}

    {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                    "rootCtx" $ "objectData" $objectData
                    "name" $name "caller" "networkpolicy"
                    "key" "networkpolicy")) -}}

    {{- if eq $expandName "true" -}}
      {{/* Expand the name of the networkpolicy if expandName resolves to true */}}
      {{- $objectName = $fullname -}}
    {{- end -}}

    {{- if and (eq $expandName "true") (not $objectData.primary) -}}
      {{/* If the networkpolicy is not primary append its name to fullname */}}
      {{- $objectName = (printf "%s-%s" $fullname $name) -}}
    {{- end -}}

    {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

    {{/* Perform validations */}}
    {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
    {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "networkpolicy") -}}
    {{- include "tc.v1.common.lib.networkpolicy.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{/* Set the name of the networkpolicy */}}
    {{- $_ := set $objectData "name" $objectName -}}
    {{- $_ := set $objectData "shortName" $name -}}

    {{/* Call class to create the object */}}
    {{- include "tc.v1.common.class.networkpolicy" (dict "rootCtx" $ "objectData" $objectData) -}}
  {{- end -}}

  {{/* Update internalUrls after the loop */}}
  {{- $_ := set $.Values.chartContext "internalUrls" $allUrls -}}
{{- end -}}
