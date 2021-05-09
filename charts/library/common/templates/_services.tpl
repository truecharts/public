{{/*
Renders the Service objects required by the chart by returning a concatinated list
of the main Service and any additionalServices.
*/}}
{{- define "common.services" -}}
  {{- if .Values.services -}}
        {{- /* Add dict of primary services */ -}}
    {{- range $name, $service := .Values.services }}
      {{- if or ( $service.enabled ) ( eq $name "main" ) -}}
        {{- print ("---") | nindent 0 -}}
        {{- print ("\n") | nindent 0 -}}
        {{- $serviceValues := $service -}}

        {{- /* Dont add name suffix for primary service named "main" */ -}}
        {{- if and (not $serviceValues.nameSuffix) ( ne $name "main" ) -}}
          {{- $_ := set $serviceValues "nameSuffix" $name -}}
        {{ end -}}
        {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
        {{- include "common.classes.service" $ -}}
    {{- end }}
    {{- end }}
  {{- end }}


  {{- if .Values.additionalServices -}}
    {{- /* Generate additional services as required */ -}}
    {{- range $index, $extraService := .Values.additionalServices }}
      {{- if $extraService.enabled -}}
        {{- print ("---") | nindent 0 -}}
        {{- $serviceValues := $extraService -}}

        {{- $name := $index -}}
        {{- if  $serviceValues.name -}}
          {{- $name := $serviceValues.name -}}
        {{- end }}

        {{- /* Dont add name suffix for primary service named "main" */ -}}
        {{- if and (not $serviceValues.nameSuffix) ( ne ( $name | quote ) "main" ) -}}
          {{- $_ := set $serviceValues "nameSuffix" $name -}}
        {{ end -}}
        {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
        {{- include "common.classes.service" $ -}}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
