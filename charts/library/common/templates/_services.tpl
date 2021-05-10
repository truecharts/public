{{/*
Renders the Service objects required by the chart by returning a concatinated list
of the main Service and any additionalservice.
*/}}
{{- define "common.services" -}}
  {{- if .Values.services -}}
    {{- range $name, $service := .Values.services }}
      {{- if $service.enabled -}}
        {{- print ("---\n") | nindent 0 -}}
        {{- $serviceValues := $service -}}

        {{- if $serviceValues.nameSuffix -}}
          {{- $_ := set $serviceValues "nameSuffix" $name -}}
        {{ end -}}

        {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
        {{- include "common.classes.service" $ -}}
    {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
