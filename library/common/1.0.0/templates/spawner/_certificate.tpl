{{/*
Call this from anywhere to create a Secret/k8s.tls
Pass a "root" object and the "certName"
(certName comes from Scale's GUI definitions)
If you also pass a "key" when calling this spawner,
instead of creating a secret it will return you the value
of that key (if exists)
*/}}
{{- define "ix.v1.common.spawner.certificate" -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}

  {{- if .key -}}
    {{- include "ix.v1.common.class.certificate" (dict "root" $root "key" .key "certName" .certName) -}}
  {{- else -}}
    {{- include "ix.v1.common.class.certificate" (dict "root" $root "certName" .certName) -}}
  {{- end -}}
{{- end -}}
