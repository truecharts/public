{{/*
Renders the Ingress objects required by the chart by returning a concatinated list
of the main Ingress and any additionalIngresses.
*/}}
{{- define "common.ingressRoute" -}}
    {{- /* Generate named ingressRoute as required */ -}}
    {{- range $name, $ingressRoute := .Values.ingressRoute }}
      {{- if $ingressRoute.enabled -}}
        {{- print ("---\n") | nindent 0 -}}
        {{- $ingressRouteValues := $ingressRoute -}}

        {{/* set defaults */}}
        {{- if not $ingressRouteValues.nameSuffix -}}
          {{- $_ := set $ingressRouteValues "nameSuffix" $name -}}
        {{ end -}}

        {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressRouteValues) -}}

        {{- if eq $ingressRouteValues.type "TCP" }}
        {{- include "common.classes.ingressRouteTCP" $ }}
        {{- else if eq $ingressRouteValues.type "UDP" }}
        {{- include "common.classes.ingressRouteUDP" $ }}
        {{- else }}
        {{- include "common.classes.ingressRoute" $ }}
        {{- end }}

        {{- if $ingressRouteValues.tls }}
          {{- if $ingressRouteValues.tls.scaleCert }}
            {{- $tlsValues := $ingressRouteValues.tls }}
            {{- $_ := set $tlsValues "nameSuffix" $ingressRouteValues.nameSuffix -}}
            {{- $_ := set $ "ObjectValues" (dict "certHolder" $tlsValues) -}}
            {{- print ("---\n") | nindent 0 -}}
            {{- include "common.cert.secret" $ -}}
          {{- end }}
        {{- end }}


      {{- end }}
    {{- end }}
{{- end }}
