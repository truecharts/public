{{/*
Renders the additional ingress objects from appIngress
*/}}
{{- define "common.appIngress" -}}
  {{- /* Generate TrueNAS SCALE app services as required v1 */ -}}
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
              {{- include "common.classes.appIngressUDP" $ }}
            {{- else if eq $ingressValues.type "TCP" -}}
              {{- include "common.classes.appIngressTCP" $ }}
            {{- else }}
              {{- include "common.classes.appIngressHTTP" $ }}
			  {{- if $ingressValues.authForwardURL }}
                {{- include "common.classes.appAuthForward" $ }}
              {{- end }}
            {{- end }}
          {{- else }}
            {{- include "common.classes.appIngressHTTP" $ }}
			{{- if $ingressValues.authForwardURL }}
              {{- include "common.classes.appAuthForward" $ }}
            {{- end }}
          {{- end }}
		  {{- $_ := set $ "ObjectValues" (dict "certHolder" $ingressValues) -}}
		  {{- print ("---") | nindent 0 -}}
		  {{- include "common.resources.cert.secret" $ }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
