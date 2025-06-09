{{/* Returns pod affinity  */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.affinity" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.affinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $affinity := list -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.affinity -}}
    {{- $affinity = . -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- with $objectData.podSpec.affinity -}}
    {{- $affinity = . -}}
  {{- end -}}

  {{- $validTypes := (list "Deployment" "StatefulSet") -}}
   {{/* TODO: We need to merge default with user input */}}
  {{- $defaultAffinity := (include "tc.v1.common.lib.pod.defaultAffinity" (dict "rootCtx" $rootCtx "objectData" $objectData) | fromJson) -}}
  {{- if and (mustHas $objectData.type $validTypes) $rootCtx.Values.podOptions.defaultAffinity }}
    {{- $affinity | toYaml -}}
  {{- else -}}
    {{- with $affinity -}} {{/* TODO: Template this, so we can add some validation around easy to make mistakes. Low Prio */}}
      {{- . | toYaml | nindent 0 }}
    {{- end -}}
  {{- end -}}

{{- end -}}

{{- define "tc.v1.common.lib.pod.defaultAffinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $selectedVolumes := (include "tc.v1.common.lib.pod.volumes.selected" (dict "rootCtx" $rootCtx "objectData" $objectData)) | fromJson }}

  {{- $names := list -}}
  {{- range $volume := $selectedVolumes.pvc -}}
    {{- $names = mustAppend $names $volume.shortName -}}
  {{- end }}

  {{- $defaultAffinity := dict
    "podAffinity" dict
      "requiredDuringSchedulingIgnoredDuringExecution" list
        dict
          "topologyKey" "kubernetes.io/hostname"
          "labelSelector" dict
            "matchExpressions" list
              dict
                "key" "truecharts.org/pvc"
                "operator" "In"
                "values" $names
  -}}

  {{- if $names -}}{{- $defaultAffinity | toJson -}}{{- end -}}
{{- end -}}
