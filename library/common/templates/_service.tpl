{{/*
Renders the Service objects required by the chart by returning a concatinated list
of the main Service and any additionalServices.
*/}}
{{- define "common.service" -}}
  {{- if .Values.service.enabled -}}
    {{- /* Generate primary service */ -}}
    {{- include "common.classes.service" . }}
    {{- /* Generate additional services as required */ -}}
    {{- range $index, $extraService := .Values.service.additionalServices }}
      {{- if $extraService.enabled -}}
        {{- print ("---") | nindent 0 -}}
        {{- $serviceValues := $extraService -}}
        {{- if not $serviceValues.nameSuffix -}}
          {{- $_ := set $serviceValues "nameSuffix" $index -}}
        {{ end -}}
        {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
        {{- include "common.classes.service" $ -}}
      {{- end }}
    {{- end }}
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
{{- end }}
