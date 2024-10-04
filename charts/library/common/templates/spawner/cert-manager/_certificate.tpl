{{/* Certificate Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.priorityclass" $ -}}
*/}}

{{- define "tc.v1.common.spawner.certificate" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $cert := .Values.certificate -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $cert
                    "name" $name "caller" "Cert Manager Certificate"
                    "key" "certificate")) -}}
    {{- if eq $enabled "true" -}}
      {{- $objectData := (mustDeepCopy $cert) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Cert Manager Certificate"
                "key" "certificate")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{/* If a certificateSecretTemplate is defined, adjust name */}}
      {{- if $objectData.certificateSecretTemplate }}
        {{- $objectName = printf "certificate-issuer-%s" $name -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Cert Manager Certificate") -}}
      {{- include "tc.v1.common.lib.certificate.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{/* Set the name of the secret */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.certificate" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
