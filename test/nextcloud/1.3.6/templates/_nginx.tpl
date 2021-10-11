{{/*
Retrieve true/false if certificate is configured
*/}}
{{- define "nginx.certAvailable" -}}
{{- if .Values.certificate -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate) -}}
{{- template "common.resources.cert_present" $values -}}
{{- else -}}
{{- false -}}
{{- end -}}
{{- end -}}


{{/*
Retrieve public key of certificate
*/}}
{{- define "nginx.cert.publicKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate "publicKey" true) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}


{{/*
Retrieve private key of certificate
*/}}
{{- define "nginx.cert.privateKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}


{{/*
Retrieve configured protocol scheme for nextcloud
*/}}
{{- define "nginx.scheme" -}}
{{- if eq (include "nginx.certAvailable" .) "true" -}}
{{- print "https" -}}
{{- else -}}
{{- print "http" -}}
{{- end -}}
{{- end -}}


{{/*
Retrieve nginx certificate secret name
*/}}
{{- define "nginx.secretName" -}}
{{- print "nginx-secret" -}}
{{- end -}}


{{/*
Formats volumeMount for tls keys and trusted certs
*/}}
{{- define "nginx.tlsKeysVolumeMount" -}}
{{- if eq (include "nginx.certAvailable" .) "true" -}}
- name: cert-secret-volume
  mountPath: "/etc/nginx"
{{- end -}}
{{- end -}}

{{/*
Formats volume for tls keys and trusted certs
*/}}
{{- define "nginx.tlsKeysVolume" -}}
{{- if eq (include "nginx.certAvailable" .) "true" -}}
- name: cert-secret-volume
  secret:
    secretName: {{ include "nginx.secretName" . }}
    items:
    - key: certPublicKey
      path: public.crt
    - key: certPrivateKey
      path: private.key
{{- end -}}
{{- end -}}
