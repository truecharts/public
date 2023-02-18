{{/* Workload Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.workload" $ -}}
*/}}

{{- define "tc.v1.common.spawner.workload" -}}

  {{/* Primary validation for enabled workload. */}}
  {{- include "tc.v1.common.lib.workload.primaryValidation" $ -}}

  {{- range $name, $workload := .Values.workload -}}

    {{- if $workload.enabled -}}

      {{/* Create a copy of the workload */}}
      {{- $objectData := (mustDeepCopy $workload) -}}

      {{/* Generate the name of the workload */}}
      {{- $objectName := include "tc.v1.common.lib.chart.names.fullname" $ -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $name -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Workload") -}}

      {{/* Set the name of the workload */}}
      {{- $_ := set $objectData "name" $objectName -}}

      {{/* Short name is the one that defined on the chart, used on selectors */}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Set the podSpec so it doesn't fail on nil pointer */}}
      {{- if not (hasKey $objectData "podSpec") -}}
        {{- fail "Workload - Expected <podSpec> key to exist" -}}
      {{- end -}}

      {{/* Call class to create the object */}}
      {{- if eq $objectData.type "Deployment" -}}
        {{- include "tc.v1.common.class.deployment" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "StatefulSet" -}}
        {{- include "tc.v1.common.class.statefulset" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "DaemonSet" -}}
        {{- include "tc.v1.common.class.daemonset" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "Job" -}}
        {{- include "tc.v1.common.class.job" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "CronJob" -}}
        {{- include "tc.v1.common.class.cronjob" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- end -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
