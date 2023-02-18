{{/* Certificate Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.scaleCertificate.validation" (dict "objectData" $objectData) -}}
objectData: The object data of the certificate.
*/}}

{{- define "tc.v1.common.lib.scaleCertificate.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.id -}}
    {{- fail "Certificate - Expected non-empty <id>" -}}
  {{- end -}}

  {{- if and $objectData.targetSelector (not (kindIs "map" $objectData.targetSelector)) -}}
    {{- fail (printf "Certificate - Expected <targetSelector> to be a [map], but got [%s]" (kindOf $objectData.targetSelector)) -}}
  {{- end -}}

{{- end -}}
