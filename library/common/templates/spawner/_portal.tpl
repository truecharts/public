{{/* Portal Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.portal" $ -}}
*/}}

{{- define "tc.v1.common.spawner.portal" -}}
  {{/* Only run this on SCALE */}}
  {{- if $.Values.global.ixChartContext -}}
    {{- range $name, $portal := $.Values.portal -}}

      {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                      "rootCtx" $ "objectData" $portal
                      "name" $name "caller" "Portal"
                      "key" "portal")) -}}

      {{- if eq $enabled "true" -}}

        {{/* Create a copy of the portal */}}
        {{- $objectData := (mustDeepCopy $portal) -}}
        {{- $_ := set $objectData "isPortal" true -}}

        {{- $context := (include "tc.v1.common.lib.util.chartcontext.data" (dict "rootCtx" $ "objectData" $objectData) | fromYaml) -}}

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

        {{/* iXportals */}}
        {{- $useNodeIP := false -}}
        {{- if eq $context.appHost "$node_ip" -}}
          {{- $useNodeIP = true -}}
        {{- end -}}

        {{- $iXPortalData := (dict
          "portalName" $name "useNodeIP" $useNodeIP
          "protocol" $context.appProtocol "host" $context.appHost
          "port" $context.appPort "path" $context.appPath
          "url" $context.appUrlWithPortAndPath
        ) -}}

        {{- $iXPortals := append $.Values.iXPortals $iXPortalData -}}
        {{- $_ := set $.Values "iXPortals" $iXPortals -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
