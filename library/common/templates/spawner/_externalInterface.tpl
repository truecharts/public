{{/* External Interface Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.externalInterface" $ -}}
*/}}

{{- define "tc.v1.common.spawner.externalInterface" -}}

  {{- range $iface := .Values.scaleExternalInterface -}}
    {{- include "tc.v1.common.lib.externalInterface.validation" (dict "objectData" $iface) -}}
  {{- end -}}

  {{/* Now we have validated interfaces, render the objects */}}

  {{- range $index, $interface := .Values.ixExternalInterfacesConfiguration -}}

    {{- $objectData := dict -}}
    {{/* Create a copy of the interface and put it in objectData.config */}}
    {{- $_ := set $objectData "config" (mustDeepCopy $interface) -}}

    {{- $objectName := (printf "ix-%s-%v" $.Release.Name $index) -}}
    {{/* Perform validations */}}
    {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}

    {{/* Set the name of the object to objectData.name */}}
    {{- $_ := set $objectData "name" $objectName -}}

    {{/* Call class to create the object */}}
    {{- include "tc.v1.common.class.networkAttachmentDefinition" (dict "rootCtx" $ "objectData" $objectData) -}}

  {{- end -}}

{{- end -}}
