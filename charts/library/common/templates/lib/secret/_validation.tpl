{{/* Secret Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.secret.validation" (dict "objectData" $objectData) -}}
objectData:
  labels: The labels of the secret.
  annotations: The annotations of the secret.
  data: The data of the secret.
*/}}

{{- define "tc.v1.common.lib.secret.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if $objectData.stringData -}}
    {{- fail "Secret - Key [stringData] is not supported" -}}
  {{- end -}}

  {{- if ne $objectData.type "kubernetes.io/service-account-token" -}}
    {{- if and (not $objectData.data) -}}
      {{- fail "Secret - Expected non-empty [data]" -}}
    {{- end -}}

    {{- if and $objectData.data (not (kindIs "map" $objectData.data)) -}}
      {{- fail (printf "Secret - Expected [data] to be a dictionary, but got [%v]" (kindOf $objectData.data)) -}}
    {{- end -}}

    {{- if and (hasKey $objectData "type") (not $objectData.type) -}}
      {{- fail (printf "Secret - Expected non-empty [type] key") -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
