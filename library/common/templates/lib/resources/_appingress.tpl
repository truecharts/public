{{/*
Renders the additional ingress objects from appIngress
*/}}
{{- define "common.appIngress" -}}
  {{- if .Values.appIngress -}}
    {{- range $name, $ingr := .Values.appIngress }}
      {{- if $ingr.enabled -}}
          {{- print ("---") | nindent 0 -}}
          {{- $ingressValues := $ingr -}}
          {{- if not $ingressValues.nameSuffix -}}
            {{- $_ := set $ingressValues "nameSuffix" $name -}}
          {{ end -}}
		  {{- $_ := set $ "ObjectValues" (dict "appIngress" $ingressValues) -}}
          {{- if $ingressValues.type -}}
            {{- if eq $ingressValues.type "UDP" -}}
              {{- include "common.classes.appIngressUDP" $ | nindent 0 -}}
            {{- else if eq $ingressValues.type "TCP" -}}
              {{- include "common.classes.appIngressTCP" $ | nindent 0 -}}
            {{- else }}
              {{- include "common.classes.appIngressHTTP" $ | nindent 0 -}}
			  {{- if $ingressValues.authForwardURL }}
                {{- include "common.classes.appAuthForward" $ | nindent 0 -}}
              {{- end }}
            {{- end }}
          {{- else }}
            {{- include "common.classes.appIngressHTTP" $ | nindent 0 -}}
			{{- if $ingressValues.authForwardURL }}
              {{- include "common.classes.appAuthForward" $ | nindent 0 -}}
            {{- end }}
          {{- end }}
		  {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
		  {- if eq $ingressValues.certType "ixcert" -}}
		  {{- print ("---") | nindent 0 -}}
		  {{- include "common.resources.cert.secret" $ | nindent 0 -}}
		  {{- else }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
