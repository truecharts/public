

{{/* External Interface Annotations that are added to podSpec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.externalInterfacePodAnnotations" (dict "rootCtx" $ "podShortName" $podShortName) }}
rootCtx is the root context of the chart
objectData is object containing the data of the pod
*/}}
{{- define "tc.v1.common.lib.metadata.externalInterfacePodAnnotations" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $ifaceIndexes := list -}}

  {{- range $index, $iface := $rootCtx.Values.scaleExternalInterface -}}
    {{/* If targetSelectAll is set append the index */}}
    {{- if .targetSelectAll -}}
      {{- $ifaceIndexes = mustAppend $ifaceIndexes $index -}}
    {{/* Else If targetSelector is set and pod is selected append the index */}}
    {{- else if and .targetSelector (mustHas $objectData.shortName .targetSelector) -}}
      {{- $ifaceIndexes = mustAppend $ifaceIndexes $index -}}
    {{/* Else If none of the above, but pod is primary append the index */}}
    {{- else if $objectData.primary -}}
      {{- $ifaceIndexes = mustAppend $ifaceIndexes $index -}}
    {{- end -}}
  {{- end -}}

  {{- $ifaceNames := list -}}
  {{- if $rootCtx.Values.ixExternalInterfacesConfiguration -}}
    {{- with $rootCtx.Values.ixExternalInterfacesConfigurationNames -}}
      {{- range $ifaceName := . -}}
        {{/* Get the index by splitting the iFaceName (ix-RELEASE-NAME-0) */}}
        {{- $index := splitList "-" $ifaceName -}}
        {{/* And pick the last item on the list */}}
        {{- $index = mustLast $index -}}

        {{/* If the index is in the list of indexes to be added, append the name */}}
        {{- if mustHas (int $index) $ifaceIndexes -}}
          {{- $ifaceNames = mustAppend $ifaceNames $ifaceName -}}
        {{- end -}}

      {{- end -}}
    {{- else -}}
      {{- fail "External Interface - Expected non empty <ixExternalInterfaceConfigurationNames>" -}}
    {{- end -}}
  {{- end -}}

  {{/* If we have ifaceNames, then add the annotations to the pod calling this template */}}
  {{- if $ifaceNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " $ifaceNames }}
  {{- end -}}
{{- end -}}
