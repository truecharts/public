{{/*
Renders the additional ingress objects from appIngress
*/}}
{{- define "custom.appIngress" -}}
  {{- /* Generate TrueNAS SCALE app services as required v1 */ -}}
  {{- if and .Values.appIngressEnabled .Values.appIngress -}}
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
              {{- include "custom.classes.ingressrouteUDP" $ }}
            {{- else if eq $ingressValues.type "TCP" -}}
              {{- include "custom.classes.ingressrouteTCP" $ }}
            {{- else }}
              {{- include "custom.classes.appIngressHTTP" $ }}
			  {{- if $ingressValues.authForwardURL }}
                {{- include "custom.classes.appAuthForward" $ }}
              {{- end }}
            {{- end }}
          {{- else }}
            {{- include "custom.classes.appIngressHTTP" $ }}
			  {{- if $ingressValues.authForwardURL }}
                {{- include "custom.classes.appAuthForward" $ }}
              {{- end }}
          {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}