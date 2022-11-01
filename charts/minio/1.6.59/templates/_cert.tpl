{{/*
Formats volumeMount for Minio tls keys and trusted certs
*/}}
{{- define "minio.tlsKeysVolumeMount" -}}
{{- if eq (include "minio.certAvailable" .) "true" -}}
- name: cert-secret-volume
  mountPath: "/etc/minio/certs"
- name: trusted-cert-secret-volume
  mountPath: "/etc/minio/certs/CAs"
{{- end }}
{{- end -}}

{{/*
Formats volume for Minio tls keys and trusted certs
*/}}
{{- define "minio.tlsKeysVolume" -}}
{{- if eq (include "minio.certAvailable" .) "true" -}}
- name: cert-secret-volume
  secret:
    secretName: {{ include "minio.secretName" . }}
    items:
    - key: certPublicKey
      path: public.crt
    - key: certPrivateKey
      path: private.key
- name: trusted-cert-secret-volume
  secret:
    secretName: {{ include "minio.secretName" . }}
    items:
    - key: certPublicKey
      path: public.crt
{{- end }}
{{- end -}}
