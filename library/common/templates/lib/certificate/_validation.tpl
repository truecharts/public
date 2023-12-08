{{/* Certificate Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.certificate.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The Certificate object.
*/}}

{{- define "tc.v1.common.lib.certificate.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.certificateIssuer -}}
    {{- fail "Cert Manager Certificate - Expected non-empty [certificateIssuer]" -}}
  {{- end -}}

  {{- if not $objectData.hosts -}}
    {{- fail "Cert Manager Certificate - Expected non-empty [hosts]" -}}
  {{- end -}}

  {{- if not (kindIs "slice" $objectData.hosts) -}}
    {{- fail (printf "Cert Manager Certificate - Expected [hosts] to be a [slice], but got [%s]" (kindOf $objectData.hosts)) -}}
  {{- end -}}

  {{- range $h := $objectData.hosts -}}
    {{- if not $h -}}
      {{- fail "Cert Manager Certificate - Expected non-empty entry in [hosts]" -}}
    {{- end -}}

    {{- $host := tpl $h $rootCtx -}}
    {{- if (hasPrefix "http://" $host) -}}
      {{- fail (printf "Cert Manager Certificate - Expected entry in [hosts] to not start with [http://], but got [%s]" $host) -}}
    {{- end -}}
    {{- if (hasPrefix "https://" $host) -}}
      {{- fail (printf "Cert Manager Certificate - Expected entry in [hosts] to not start with [https://], but got [%s]" $host) -}}
    {{- end -}}
    {{- if (contains ":" $host) -}}
      {{- fail (printf "Cert Manager Certificate - Expected entry in [hosts] to not contain [:], but got [%s]" $host) -}}
    {{- end -}}

    {{- with $objectData.certificateSecretTemplate -}}
      {{- if and (not .labels) (not .annotations) -}}
        {{- fail "Cert Manager Certificate - Expected [certificateSecretTemplate] to have at least one of [labels, annotations]" -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData.certificateSecretTemplate "caller" "Cert Manager Certificate (certificateSecretTemplate)") -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
