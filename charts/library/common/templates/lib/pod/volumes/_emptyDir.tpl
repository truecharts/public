{{/* Returns emptyDir Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.emptyDir" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.emptyDir" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $medium := "" -}}
  {{- $size := "" -}}
  {{- with $objectData.medium -}}
    {{- $medium = tpl . $rootCtx -}}
  {{- end -}}
  {{- with $objectData.size -}}
    {{- $size = tpl . $rootCtx -}}
  {{- end -}}

  {{- if $size -}}
    {{/* Size: https://regex101.com/r/NNPV2D/1 */}}
    {{- if not (mustRegexMatch "^[1-9][0-9]*([EPTGMK]i?|e[0-9]+)?$" (toString $size)) -}}
      {{- $formats := "(Suffixed with E/P/T/G/M/K - eg. 1G), (Suffixed with Ei/Pi/Ti/Gi/Mi/Ki - eg. 1Gi), (Plain Integer in bytes - eg. 1024), (Exponent - eg. 134e6)" -}}
      {{- fail (printf "Persistence Expected [size] to have one of the following formats [%s], but got [%s]" $formats $size) -}}
    {{- end -}}
  {{- else if eq $medium "Memory" -}}
    {{- $size = $rootCtx.Values.resources.limits.memory -}}
  {{- end -}}

  {{- if and $medium (ne $medium "Memory") -}}
    {{- fail (printf "Persistence - Expected [medium] to be one of [\"\", Memory], but got [%s] on [emptyDir] type" $medium)  -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  {{- if or $medium $size }}
  emptyDir:
    {{- if $medium }}
    medium: {{ $medium }}
    {{- end -}}
    {{- if $size }}
    sizeLimit: {{ $size }}
    {{- end -}}
  {{- else }}
  emptyDir: {}
  {{- end -}}
{{- end -}}
