{{/* Service Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.service" $ -}}
*/}}

{{- define "tc.v1.common.spawner.service" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{/* Primary validation for enabled service. */}}
  {{- include "tc.v1.common.lib.service.primaryValidation" $ -}}
  {{- $allUrls := $.Values.chartContext.internalUrls | default (list) }}  # Initialize with existing URLs or an empty list

  {{- range $name, $service := .Values.service -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $service
                    "name" $name "caller" "Service"
                    "key" "service")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the configmap */}}
      {{- $objectData := (mustDeepCopy $service) -}}
      {{ $namespace := (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $ "objectData" $service "caller" "Service")) }}

      {{/* Init object name */}}
      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                      "rootCtx" $ "objectData" $objectData
                      "name" $name "caller" "Service"
                      "key" "service")) -}}

      {{- if eq $expandName "true" -}}
        {{/* Expand the name of the service if expandName resolves to true */}}
        {{- $objectName = $fullname -}}
      {{- end -}}

      {{- if and (eq $expandName "true") (not $objectData.primary) -}}
        {{/* If the service is not primary append its name to fullname */}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Service") -}}
      {{- include "tc.v1.common.lib.service.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{/* Set the name of the service */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Now iterate over the ports in the service */}}
      {{- range $port := $objectData.ports }}
        {{- $enabledP := (include "tc.v1.common.lib.util.enabled" (dict
                      "rootCtx" $ "objectData" $port
                      "name" $name "caller" "service"
                      "key" "port")) -}}
        {{- if eq $enabledP "true" -}}
          
          {{- $internalUrls := (printf "%s.%s.svc.cluster.local:%s" $objectName $namespace $port.port) }}
          {{- $allUrls = append $allUrls $internalUrls }}  # Collect the new URLs in $allUrls
        {{- end }}
      {{- end }}

      {{- end }}
    {{- end -}}

    {{/* Call class to create the object */}}
    {{- include "tc.v1.common.class.service" (dict "rootCtx" $ "objectData" $objectData) -}}

  {{- end -}}

{{- $_ := set $.Values.chartContext "internalUrls" $allUrls -}}  # Update internalUrls after the loop

{{- end -}}
