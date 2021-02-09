{{/*
Renders the additional ingress objects from appIngress
*/}}
{{- define "common.custom.appIngress" -}}
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
              {{- include "common.custom.classes.appIngressUDP" $ }}
            {{- else if eq $ingressValues.type "TCP" -}}
              {{- include "common.custom.classes.appIngressTCP" $ }}
            {{- else }}
              {{- include "common.custom.classes.appIngressHTTP" $ }}
			  {{- if $ingressValues.authForwardURL }}
                {{- include "common.custom.classes.appAuthForward" $ }}
              {{- end }}
            {{- end }}
          {{- else }}
            {{- include "common.custom.classes.appIngressHTTP" $ }}
			{{- if $ingressValues.authForwardURL }}
              {{- include "common.custom.classes.appAuthForward" $ }}
            {{- end }}
          {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}