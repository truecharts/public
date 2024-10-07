{{/*
Retrieve true/false if certificate is configured
*/}}
{{- define "common.resources.cert.available" -}}
{{- if .ObjectValues.certHolder.certificate -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.ObjectValues.certHolder.certificate) -}}
{{- template "common.resources.cert_present" $values -}}
{{- else -}}
{{- false -}}
{{- end -}}
{{- end -}}


{{/*
Retrieve public key of certificate
*/}}
{{- define "common.resources.cert.publicKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.ObjectValues.certHolder.certificate "publicKey" true) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}


{{/*
Retrieve private key of certificate
*/}}
{{- define "common.resources.cert.privateKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.ObjectValues.certHolder.certificate) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}
