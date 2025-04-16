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
  {{- $pvcLabels := (include "tc.v1.common.lib.metadata.volumeLabels" (dict "rootCtx" $rootCtx "objectData" $objectData) | fromYaml ) -}}
  {{- if and (mustHas $objectData.type $validTypes) $pvcLabels $rootCtx.Values.podOptions.defaultAffinity }}
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
            - key: app
              operator: In
              values:
                - {{ $pvcLabels | toYaml }}
        topologyKey: "kubernetes.io/hostname"
  {{- else -}}
  {{- with $affinity -}} {{/* TODO: Template this, so we can add some validation around easy to make mistakes. Low Prio */}}
    {{- . | toYaml | nindent 0 }}
  {{- end -}}
  {{- end -}}

{{- end -}}
