{{/* Renders the Ingress objects required by the chart */}}
{{- define "common.ingress" -}}
  {{- /* Generate named ingresses as required */ -}}
  {{- range $name, $ingress := .Values.ingress }}
    {{- if $ingress.enabled -}}
      {{- $ingressValues := $ingress -}}

      {{/* set defaults */}}
      {{- if and (not $ingressValues.nameOverride) (ne $name (include "common.ingress.primary" $)) -}}
        {{- $_ := set $ingressValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
      {{- include "common.classes.ingress" $ }}

      {{- range $index, $tlsValues :=  $ingressValues.tls }}
        {{- if .scaleCert }}
          {{- $nameOverride := ( printf "%v-%v" "tls" $index ) -}}
          {{- if $ingressValues.nameOverride -}}
          {{- $nameOverride = ( printf "%v-%v-%v" $ingressValues.nameOverride "tls" $index ) -}}
          {{- end }}
          {{- $_ := set $tlsValues "nameOverride" $nameOverride -}}
          {{- $_ := set $ "ObjectValues" (dict "certHolder" $tlsValues) -}}
          {{- include "common.cert.secret" $ }}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{/* Return the name of the primary ingress object */}}
{{- define "common.ingress.primary" -}}
  {{- $enabledIngresses := dict -}}
  {{- range $name, $ingress := .Values.ingress -}}
    {{- if $ingress.enabled -}}
      {{- $_ := set $enabledIngresses $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $ingress := $enabledIngresses -}}
    {{- if and (hasKey $ingress "primary") $ingress.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledIngresses | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
