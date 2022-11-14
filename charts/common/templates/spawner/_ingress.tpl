{{/* Renders the Ingress objects required by the chart */}}
{{- define "tc.common.spawner.ingress" -}}
  {{/* Generate named ingresses as required */}}
  {{- range $name, $ingress := .Values.ingress }}
    {{- if $ingress.enabled -}}
      {{- $ingressValues := $ingress -}}

      {{/* set defaults */}}
      {{- if and (not $ingressValues.nameOverride) (ne $name (include "tc.common.lib.util.ingress.primary" $)) -}}
        {{- $_ := set $ingressValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
      {{- include "tc.common.class.ingress" $ }}

      {{- range $index, $tlsValues :=  $ingressValues.tls }}
        {{- if and ( .scaleCert ) ( $.Values.global.ixChartContext ) }}
          {{- $nameOverride := ( printf "%v-%v" "tls" $index ) -}}
          {{- if $ingressValues.nameOverride -}}
          {{- $nameOverride = ( printf "%v-%v-%v" $ingressValues.nameOverride "tls" $index ) -}}
          {{- end }}
          {{- $_ := set $tlsValues "nameOverride" $nameOverride -}}
          {{- $_ := set $ "ObjectValues" (dict "certHolder" $tlsValues) -}}
          {{- include "tc.common.scale.cert.secret" $ }}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
