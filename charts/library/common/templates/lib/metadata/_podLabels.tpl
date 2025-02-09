{{/* Labels that are added to podSpec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.podLabels" $ }}
*/}}
{{- define "tc.v1.common.lib.metadata.podLabels" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $type := $objectData.type -}}

  {{- $label := "" -}}
  {{- $fleeting := (list "CronJob" "Job") -}}
  {{- if (mustHas $type $fleeting) -}}
    {{- $label = "fleeting" -}}
  {{- end -}}

  {{- $permanent := (list "Deployment" "StatefulSet" "DaemonSet") -}}
  {{- if (mustHas $type $permanent) -}}
    {{- $label = "permanent" -}}
  {{- end -}}

  {{- if not $label -}}
    {{- fail "PodLabels - Template used in a place that is not designed to be used" -}}
  {{- end }}
pod.lifecycle: {{ $label }}

{{- end -}}
