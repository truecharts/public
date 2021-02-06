{{/*
Retrieve true/false if certificate is available in ixCertificates
*/}}
{{- define "common.resources.cert_present" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" . "checkKeys" (list "commonCertOptions")) -}}
{{- hasKey $values.ixCertificates $values.commonCertOptions.certKeyName -}}
{{- end -}}


{{/*
Retrieve certificate from variable name
*/}}
{{- define "common.resources.cert" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" . "checkKeys" (list "commonCertOptions")) -}}
{{- if hasKey $values.ixCertificates $values.commonCertOptions.certKeyName -}}
{{- $cert := get $values.ixCertificates $values.commonCertOptions.certKeyName -}}
{{- if $values.commonCertOptions.publicKey -}}
{{ $cert.certificate }}
{{- else -}}
{{ $cert.privatekey }}
{{- end -}}
{{- end -}}
{{- end -}}
