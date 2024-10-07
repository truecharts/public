{{/*
Renders the Ingress objects required by the chart by returning a concatinated list
of the main Ingress and any additionalIngresses.
*/}}
{{- define "common.ingress" -}}
    {{- /* Generate named ingresses as required */ -}}
    {{- range $name, $ingress := .Values.ingress }}
      {{- $certType := $ingress.certType | default "disabled" -}}
      {{- $enabled := $ingress.enabled | default false -}}
      {{- if or ( ne $certType "disabled" ) ( $ingress.enabled ) -}}
        {{- print ("---") | nindent 0 -}}
        {{- $ingressValues := $ingress -}}

        {{/* set defaults */}}
        {{- if and (not $ingressValues.nameSuffix) ( ne $name "main" ) -}}
          {{- $_ := set $ingressValues "nameSuffix" $name -}}
        {{ end -}}

        {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
        {{- if not $ingressValues.type -}}
          {{- $_ := set $ingressValues "type" "HTTP" -}}
        {{ end -}}
        {{- if not $ingressValues.certType -}}
          {{- $_ := set $ingressValues "certType" "" -}}
        {{ end -}}

        {{- if or ( eq $ingressValues.type "TCP" ) ( eq $ingressValues.type "UDP" )  ( eq $ingressValues.type "HTTP-IR" ) -}}
        {{- include "common.classes.ingressRoute" $ -}}
        {{- else -}}
        {{- include "common.classes.ingress" $ -}}
        {{ end -}}

        {{- if eq $ingressValues.certType "ixcert" -}}
        {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
        {{- print ("---") | nindent 0 -}}
        {{- include "common.resources.cert.secret" $ }}
        {{ end -}}
      {{- end }}
    {{- end }}


    {{- /* Generate additional ingresses as required */ -}}
    {{- range $index, $additionalIngress := .Values.additionalIngress }}
      {{- $certType := $additionalIngress.certType | default "disabled" -}}
      {{- if or ( ne $certType "disabled" ) ( $additionalIngress.enabled ) -}}
        {{- print ("---") | nindent 0 -}}
        {{- $ingressValues := $additionalIngress -}}

        {{/* set defaults */}}
        {{- $name := $index -}}
        {{- if  $ingressValues.name -}}
          {{- $name := $ingressValues.name -}}
        {{- end }}

        {{- if or (not $ingressValues.nameSuffix) ( ne ( $name | quote ) "main" ) -}}
          {{- $_ := set $ingressValues "nameSuffix" $name -}}
        {{ end -}}
        {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
        {{- if not $ingressValues.type -}}
          {{- $_ := set $ingressValues "type" "HTTP" -}}
        {{ end -}}
        {{- if not $ingressValues.certType -}}
          {{- $_ := set $ingressValues "certType" "" -}}
        {{ end -}}

        {{- if or ( eq $ingressValues.type "TCP" ) ( eq $ingressValues.type "UDP" ) ( eq $ingressValues.type "HTTP-IR" ) -}}
        {{- include "common.classes.ingressRoute" $ -}}
        {{- else -}}
        {{- include "common.classes.ingress" $ -}}
        {{ end -}}

        {{- if eq $ingressValues.certType "ixcert" -}}
        {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
        {{- print ("---") | nindent 0 -}}
        {{- include "common.resources.cert.secret" $ }}
        {{ end -}}
      {{- end }}
    {{- end }}

    {{- /* Generate externalService ingresses as required */ -}}
    {{- range $index, $externalService := .Values.externalServices }}
      {{- $certType := $externalService.certType | default "disabled" -}}
      {{- if or ( ne $certType "disabled" ) ( $externalService.enabled ) -}}
        {{- print ("---") | nindent 0 -}}
        {{- $ingressValues := $externalService -}}

        {{/* set defaults */}}
        {{- $name := $index -}}
        {{- if  $ingressValues.name -}}
          {{- $name := $ingressValues.name -}}
        {{- end }}
        {{- $name = printf "%v-%v" "external" $name -}}

        {{- if or (not $ingressValues.nameSuffix) -}}
          {{- $_ := set $ingressValues "nameSuffix" $name -}}
        {{ end -}}
        {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
        {{- if not $ingressValues.type -}}
          {{- $_ := set $ingressValues "type" "HTTP" -}}
        {{ end -}}
        {{- if not $ingressValues.certType -}}
          {{- $_ := set $ingressValues "certType" "" -}}
        {{ end -}}

        {{- if or ( eq $ingressValues.type "TCP" ) ( eq $ingressValues.type "UDP" ) ( eq $ingressValues.type "HTTP-IR" ) -}}
        {{- include "common.classes.ingressRoute" $ -}}
        {{- else -}}
        {{- include "common.classes.ingress" $ -}}
        {{ end -}}

        {{- print ("---") | nindent 0 -}}
        {{- include "common.classes.externalService" $ }}

        {{- if eq $ingressValues.certType "ixcert" -}}
        {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
        {{- print ("---") | nindent 0 -}}
        {{- include "common.resources.cert.secret" $ }}
        {{ end -}}
      {{- end }}
    {{- end }}

{{- end }}
