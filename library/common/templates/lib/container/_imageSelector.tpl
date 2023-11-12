{{/* Returns the image dictionary */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.imageSelector" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.imageSelector" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $imageObj := dict -}}

  {{- $selector := "image" -}}
  {{- with $objectData.imageSelector -}}
    {{- $selector = tpl . $rootCtx -}}
  {{- end -}}

  {{- if hasKey $rootCtx.Values $selector -}}
    {{- $imageObj = get $rootCtx.Values $selector -}}
  {{- else -}}
    {{- fail (printf "Container - Expected [.Values.%s] to exist" $selector) -}}
  {{- end -}}

  {{- if not $imageObj.repository -}}
    {{- fail (printf "Container - Expected non-empty [.Values.%s.repository]" $selector) -}}
  {{- end -}}

  {{- if not $imageObj.tag -}}
    {{- fail (printf "Container - Expected non-empty [.Values.%s.tag]" $selector) -}}
  {{- end -}}

  {{- if not $imageObj.pullPolicy -}}
    {{- $_ := set $imageObj "pullPolicy" "IfNotPresent" -}}
  {{- end -}}

  {{- $policies := (list "IfNotPresent" "Always" "Never") -}}
  {{- if not (mustHas $imageObj.pullPolicy $policies) -}}
    {{- fail (printf "Container - Expected [.Values.%s.pullPolicy] to be one of [%s], but got [%s]" $selector (join ", " $policies) $imageObj.pullPolicy) -}}
  {{- end -}}

  {{- $imageObj | toJson -}}
{{- end -}}
