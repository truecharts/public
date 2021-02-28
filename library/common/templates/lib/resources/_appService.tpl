{{/*
Renders the additioanl Service objects from appAdditionalServices
*/}}
{{- define "common.appService" -}}
  {{- /* Generate TrueNAS SCALE app services as required v1 */ -}}
  {{- if and .Values.appAdditionalServicesEnabled .Values.appAdditionalServices -}}
    {{- range $name, $srv := .Values.appAdditionalServices }}
      {{- if $srv.enabled -}}
          {{- print ("---") | nindent 0 -}}
          {{- $serviceValues := $srv -}}
          {{- if not $serviceValues.nameSuffix -}}
            {{- $_ := set $serviceValues "nameSuffix" $name -}}
          {{ end -}}
          {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
          {{- include "common.classes.service" $ -}}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
