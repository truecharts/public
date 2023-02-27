{{/* Certificate Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.scaleCertificate" $ -}}
*/}}

{{- define "tc.v1.common.spawner.scaleCertificate" -}}

  {{- range $name, $certificate := .Values.scaleCertificate -}}

    {{- if $certificate.enabled -}}

      {{/* Create a copy of the certificate */}}
      {{- $objectData := (mustDeepCopy $certificate) -}}

      {{- $objectName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $name) -}}
      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.scaleCertificate.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Certificate") -}}

      {{/* Prepare data */}}
      {{- $data := fromJson (include "tc.v1.common.lib.scaleCertificate.getData" (dict "rootCtx" $ "objectData" $objectData)) -}}
      {{- $_ := set $objectData "data" $data -}}

      {{/* Set the type to certificate */}}
      {{- $_ := set $objectData "type" "certificate" -}}

      {{/* Set the name of the certificate */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.secret" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
