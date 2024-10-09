{{/*
Retrieve true/false if certificate is available in ixCertificates
*/}}
{{- define "common.resources.cert_present" -}}
{{- $values := . -}}
{{- hasKey $values.Values.ixCertificates ($values.commonCertOptions.certKeyName | toString) -}}
{{- end -}}


{{/*
Retrieve certificate from variable name
*/}}
{{- define "common.resources.cert" -}}
{{- $values := . -}}
{{- $certKey := ($values.commonCertOptions.certKeyName | toString) -}}
{{- if hasKey $values.Values.ixCertificates $certKey -}}
{{- $cert := get $values.Values.ixCertificates $certKey -}}
{{- if $values.commonCertOptions.publicKey -}}
{{ $cert.certificate }}
{{- else -}}
{{ $cert.privatekey }}
{{- end -}}
{{- end -}}
{{- end -}}
