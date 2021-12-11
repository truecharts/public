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


{{/*
Retrieve command for minio application
*/}}
{{- define "minio.commandArgs" -}}
{{- $arg := "/usr/bin/docker-entrypoint.sh minio -S /etc/minio/certs server --console-address=':9001'" -}}
{{- if .Values.distributedMode -}}
{{- cat $arg (join " " (concat (.Values.distributedIps | default list) (.Values.extraArgs | default list))) -}}
{{- else -}}
{{- cat $arg ((concat (list "/export") (.Values.extraArgs | default list)) | join " ") -}}
{{- end -}}
{{- end -}}


{{/*
Enable host networking
*/}}
{{- define "minio.hostNetworking" -}}
{{- if .Values.distributedMode -}}
{{- print "true" -}}
{{- else -}}
{{- print "false" -}}
{{- end -}}
{{- end -}}
