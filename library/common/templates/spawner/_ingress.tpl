{{/* Renders the Ingress objects required by the chart */}}
{{- define "tc.v1.common.spawner.ingress" -}}
  {{/* Generate named ingresses as required */}}
  {{- range $name, $ingress := .Values.ingress -}}
    {{- if $ingress.enabled -}}
      {{- $ingressValues := $ingress -}}
      {{- $ingressName := include "ix.v1.common.names.fullname" $ -}}

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
          {{- $cert := dict -}}
          {{- $_ := set $cert "nameOverride" $tlsName -}}
          {{- $_ := set $cert "id" .scaleCert -}}
          {{- include "ix.v1.common.certificate.secret" (dict "root" $ "cert" $cert "name" $cert.nameOverride) -}}
        {{- end -}}
      {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
