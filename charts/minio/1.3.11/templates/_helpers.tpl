{{/*
Determine secret name.
*/}}
{{- define "minio.secretName" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}


{{/*
Retrieve true/false if minio certificate is configured
*/}}
{{- define "minio.certAvailable" -}}
{{- if .Values.certificate -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate) -}}
{{- template "common.resources.cert_present" $values -}}
{{- else -}}
{{- false -}}
{{- end -}}
{{- end -}}


{{/*
Retrieve public key of minio certificate
*/}}
{{- define "minio.cert.publicKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate "publicKey" true) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}


{{/*
Retrieve private key of minio certificate
*/}}
{{- define "minio.cert.privateKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}


{{/*
Retrieve scheme/protocol for minio
*/}}
{{- define "minio.scheme" -}}
{{- if eq (include "minio.certAvailable" .) "true" -}}
{{- print "https" -}}
{{- else -}}
{{- print "http" -}}
{{- end -}}
{{- end -}}
