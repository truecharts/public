{{/* Vertical Pod Autoscaler Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.vpa" $ -}}
*/}}

{{- define "tc.v1.common.spawner.vpa" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
    {{- range $name, $vpa := .Values.vpa -}}

    {{- $VPAenabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $vpa
                    "name" $name "caller" "VPA"
                    "key" "VPA")) -}}

  {{- if eq $VPAenabled "true" -}}
  {{- $objectData := (mustDeepCopy $vpa) -}}


  {{- range $workloadname, $workload := .Values.workload -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $workload
                    "name" $name "caller" "vpa"
                    "key" "workload")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the workload */}}
      {{- $_ := set $objectData "workload" (mustDeepCopy $workload) -}}

      {{/* Generate the name of the vpa */}}
      {{- $objectName := $fullname -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = printf "%s-%s" $fullname $workloadname -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Workload") -}}

      {{/* Set the name of the workload */}}
      {{- $_ := set $objectData "name" $objectName -}}

      {{/* Short name is the one that defined on the chart, used on selectors */}}
      {{- $_ := set $objectData "shortName" $workloadname -}}

      {{- if or ( not $objectData.targetSelector ) ( hasKey $objectData.targetSelector $workloadname ) -}}
        {{/* Call class to create the object */}}
        {{- if or ( eq $objectData.type "Deployment") ( eq $objectData.type "StatefulSet" ) ( eq $objectData.type "DaemonSet" ) -}}
          {{- include "tc.v1.common.class.vpa" (dict "rootCtx" $ "objectData" $objectData) -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}

  {{- end -}}
  {{- end -}}

{{- end -}}
