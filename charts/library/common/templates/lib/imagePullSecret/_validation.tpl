{{/* Configmap Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.imagePullSecret.validation" (dict "objectData" $objectData) -}}
objectData:
  labels: The labels of the imagePullSecret.
  annotations: The annotations of the imagePullSecret.
  data: The data of the imagePullSecret.
*/}}

{{- define "tc.v1.common.lib.imagePullSecret.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.data -}}
    {{- fail "Image Pull Secret - Expected non-empty [data]" -}}
  {{- end -}}

  {{- if not (kindIs "map" $objectData.data) -}}
    {{- fail (printf "Image Pull Secret - Expected [data] to be a dictionary, but got [%v]" (kindOf $objectData.data)) -}}
  {{- end -}}

  {{- range $key := (list "username" "password" "registry" "email") -}}
    {{- if not (get $objectData.data $key) -}}
      {{- fail (printf "Image Pull Secret - Expected non-empty [%s]" $key) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
