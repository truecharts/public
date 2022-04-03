{{/*
Enable host networking
*/}}
{{- define "hostNetworkingEnabled" -}}
{{- if or (lt (.Values.service.nodePort | int) 9000) (lt (.Values.service.farmerPort | int) 9000) -}}
{{- print "true" -}}
{{- else -}}
{{- print "false" -}}
{{- end -}}
{{- end -}}

{{/*
Enable Node Port Service
*/}}
{{- define "enableService" -}}
{{- if or (ge (.Values.service.nodePort | int) 9000) (ge (.Values.service.farmerPort | int) 9000) -}}
{{- print "true" -}}
{{- else -}}
{{- print "false" -}}
{{- end -}}
{{- end -}}
