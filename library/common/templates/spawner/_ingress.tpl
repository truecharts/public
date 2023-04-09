{{/* Renders the Ingress objects required by the chart */}}
{{- define "tc.v1.common.spawner.ingress" -}}
  {{/* Generate named ingresses as required */}}
  {{- range $name, $ingress := .Values.ingress -}}
    {{- if $ingress.enabled -}}
      {{- $ingressValues := $ingress -}}
      {{- $ingressName := include "tc.v1.common.lib.chart.names.fullname" $ -}}

      {{/* set defaults */}}
      {{- if and (not $ingressValues.nameOverride) (ne $name (include "tc.v1.common.lib.util.ingress.primary" $)) -}}
        {{- $_ := set $ingressValues "nameOverride" $name -}}
      {{- end -}}

      {{- if $ingressValues.nameOverride -}}
        {{- $ingressName = printf "%v-%v" $ingressName $ingressValues.nameOverride -}}
      {{- end -}}

      {{- $_ := set $ingressValues "name" $ingressName -}}

      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
      {{- include "tc.v1.common.class.ingress" $ -}}
      {{- if and ( $ingressValues.tls ) ( not $ingressValues.clusterIssuer ) -}}
      {{- range $index, $tlsValues :=  $ingressValues.tls -}}
        {{- $tlsName := ( printf "%v-%v" "tls" $index ) -}}
        {{- if $tlsValues.certificateIssuer -}}
          {{- include "tc.v1.common.class.certificate" (dict "root" $ "name" ( printf "%v-%v" $ingressName $tlsName ) "certificateIssuer" $tlsValues.certificateIssuer "hosts" $tlsValues.hosts ) -}}
        {{- else if and ( $tlsValues.scaleCert ) ( $.Values.global.ixChartContext ) -}}

          {{/* Create certificate object and use it to construct a secret */}}
          {{- $objectData := dict -}}
          {{- $_ := set $objectData "id" .scaleCert -}}

          {{- $objectName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $tlsName) -}}
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
    {{- else if $ingress.required -}}
      {{- fail (printf "Ingress - <ingress.%s> is set to be [required] and cannot be disabled" $name) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
