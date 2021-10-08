{{/*
Formats volumeMount for Minio tls keys and trusted certs
*/}}
{{- define "hostNetworkingEnabled" -}}
{{- if or (lt (.Values.service.nodePort | int) 9000) (lt (.Values.service.farmerPort | int) 9000) -}}
{{- print "true" -}}
{{- else -}}
{{- print "false" -}}
{{- end -}}
{{- end -}}

{{/*
Formats volume for Minio tls keys and trusted certs
*/}}
{{- define "enableService" -}}
{{- if or (ge (.Values.service.nodePort | int) 9000) (ge (.Values.service.farmerPort | int) 9000) -}}
{{- print "true" -}}
{{- else -}}
{{- print "false" -}}
{{- end -}}
{{- end -}}
