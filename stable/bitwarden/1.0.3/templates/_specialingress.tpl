{{/*
Renders the Ingress objects required by the chart by returning a concatinated list
of the main Ingress and any additionalIngresses.
*/}}
{{- define "bitwarden.ingress" -}}
  {{- $fullName := include "common.names.fullname" . -}}

  {{- range $name, $ingress := .Values.ingress }}
    {{- if $ingress.enabled -}}
        {{- print ("---") | nindent 0 -}}
      {{- $ingressValues := $ingress -}}


      {{/* Create Second Ingress */}}
      {{- $_ := set $ingressValues "nameSuffix" "extra" -}}
      {{- $_ := set ( index $ingressValues.hosts 0 ) "path" "/notifications/hub/negotiate" -}}
      {{- $_ := set $ingressValues "serviceName" $fullName -}}
      {{- $_ := set $ingressValues "servicePort" "8080" -}}



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

      {{- if $ingressValues.authForwardURL -}}
      {{- print ("---") | nindent 0 -}}
      {{- include "common.classes.ingress.authForward" $ }}
      {{ end -}}

      {{- if eq $ingressValues.certType "ixcert" -}}
      {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
      {{- print ("---") | nindent 0 -}}
      {{- include "common.resources.cert.secret" $ }}
      {{ end -}}
    {{- end }}
  {{- end }}


  {{- /* Generate named ingresses as required */ -}}
  {{- range $name, $ingress := .Values.ingress }}
    {{- if $ingress.enabled -}}
      {{- print ("---") | nindent 0 -}}
      {{- $ingressValues := $ingress -}}


      {{/* Create Second Ingress */}}
      {{- $_ := set $ingressValues "nameSuffix" "ws" -}}
      {{- $_ := set ( index $ingressValues.hosts 0 ) "path" "/notifications/hub" -}}
      {{- $svcName := printf "%v-%v" $fullName "ws" -}}
      {{- $_ := set $ingressValues "serviceName" $svcName -}}
      {{- $_ := set $ingressValues "servicePort" "3012" -}}


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

      {{- if $ingressValues.authForwardURL -}}
      {{- print ("---") | nindent 0 -}}
      {{- include "common.classes.ingress.authForward" $ }}
      {{ end -}}

      {{- if eq $ingressValues.certType "ixcert" -}}
      {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
      {{- print ("---") | nindent 0 -}}
      {{- include "common.resources.cert.secret" $ }}
      {{ end -}}
    {{- end }}
  {{- end }}




{{- end }}
