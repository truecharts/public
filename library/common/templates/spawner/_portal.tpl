{{/* Portal Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.portal" $ -}}
*/}}

{{- define "tc.v1.common.spawner.portal" -}}
  {{- range $name, $portal := $.Values.portal -}}
      {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                      "rootCtx" $ "objectData" $portal
                      "name" $name "caller" "Portal"
                      "key" "portal")) -}}

      {{- if eq $enabled "true" -}}
        {{/* Create a copy of the portal */}}
        {{- $objectData := (mustDeepCopy $portal) -}}

        {{- $context := (include "tc.v1.common.lib.util.chartcontext.data" (dict "rootCtx" $ "objectData" $objectData) | fromJson) -}}

        {{/* create configmap entry*/}}
        {{- $portalData := (dict
          "protocol" $context.appProtocol "host" $context.appHost
          "port" $context.appPort "path" $context.appPath
          "url" $context.appUrlWithPortAndPath
        ) -}}

        {{/* construct configmap */}}
        {{- $objectName := (printf "tcportal-%s" $name) -}}
        {{- $configMap := dict "name" $objectName "shortName" $objectName "data" $portalData -}}

        {{/* Perform validations */}} {{/* Configmaps have a max name length of 253 */}}
        {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
        {{- include "tc.v1.common.lib.configmap.validation" (dict "objectData" $configMap) -}}
        {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $configMap "caller" "Portal") -}}

        {{/* Call class to create the object */}}
        {{- include "tc.v1.common.class.configmap" (dict "rootCtx" $ "objectData" $configMap) -}}

        {{- $portalData := (dict
          "portalName" $name
          "protocol" $context.appProtocol "host" $context.appHost
          "port" $context.appPort "path" $context.appPath
          "url" $context.appUrlWithPortAndPath
        ) -}}

        {{- $_ := set $.Values.portal $name (dict "rendered" $portalData) -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
