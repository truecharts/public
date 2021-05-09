{{/*
Renders the Ingress objects required by the chart by returning a concatinated list
of the main Ingress and any additionalIngresses.
*/}}
{{- define "common.ingress" -}}
    {{- /* Generate named ingresses as required */ -}}
    {{- range $name, $ingress := .Values.ingress }}
      {{- if $ingress.enabled -}}
        {{- print ("---\n") | nindent 0 -}}
        {{- $ingressValues := $ingress -}}

        {{/* set defaults */}}
        {{- if not $ingressValues.nameSuffix -}}
          {{- $_ := set $ingressValues "nameSuffix" $name -}}
        {{ end -}}

        {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
        {{- include "common.classes.ingress" $ }}
      {{- end }}
    {{- end }}
{{- end }}
