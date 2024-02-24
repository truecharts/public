{{/* Ingress Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.ingress" $ -}}
*/}}

{{- define "tc.v1.common.spawner.ingress" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{/* Validate that only 1 primary exists */}}
  {{- include "tc.v1.common.lib.ingress.primaryValidation" $ -}}

  {{- range $name, $ingress := .Values.ingress -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
              "rootCtx" $ "objectData" $ingress
              "name" $name "caller" "Ingress"
              "key" "ingress")) -}}

    {{- if and (eq $enabled "false") ($ingress.required) -}}
      {{- fail (printf "Ingress - Expected ingress [%s] to be enabled. This chart is designed to work only with ingress enabled." $name) -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the ingress */}}
      {{- $objectData := (mustDeepCopy $ingress) -}}

      {{/* Init object name */}}
      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Ingress"
                "key" "ingress")) -}}

      {{- if eq $expandName "true" -}}
        {{/* Expand the name of the service if expandName resolves to true */}}
        {{- $objectName = $fullname -}}
      {{- end -}}

      {{- if and (eq $expandName "true") (not $objectData.primary) -}}
        {{/* If the ingress is not primary append its name to fullname */}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Ingress") -}}
      {{- include "tc.v1.common.lib.ingress.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{/* Set the name of the ingress */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.ingress" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{- $hasCertIssuer := false -}}
      {{- if $objectData.integrations -}}
        {{- if and $objectData.integrations.certManager $objectData.integrations.certManager.enabled -}}
          {{- $hasCertIssuer = true -}}
        {{- end -}}
      {{- end -}}

      {{- if not $hasCertIssuer -}}
        {{- range $idx, $tlsData := $objectData.tls -}}
          {{- if $tlsData.certificateIssuer -}}
            {{- $certName := printf "%s-tls-%d" $objectData.name ($idx | int) -}}

            {{- $certObjData := (dict
                "name" $certName "shortName" $name
                "hosts" $tlsData.hosts
                "certificateIssuer" $tlsData.certificateIssuer
            ) -}}

            {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $certName) -}}
            {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $certObjData "caller" "Ingress (certificateIssuer)") -}}
            {{- include "tc.v1.common.lib.certificate.validation" (dict "rootCtx" $ "objectData" $certObjData) -}}

            {{/* Create the certificate with the certData */}}
            {{- include "tc.v1.common.class.certificate" (dict "rootCtx" $ "objectData" $certObjData) -}}

          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
