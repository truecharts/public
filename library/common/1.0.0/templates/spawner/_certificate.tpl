{{- define "ix.v1.common.spawner.certificate" -}}
  {{- $root := . -}}

  {{- range $name, $cert := .Values.scaleCerts -}}
    {{- include "ix.v1.common.certificate.secret" (dict "cert" $cert "name" $name "root" $root) -}}
  {{- end -}}

  {{- range $id, $cert := .Values.scaleCertsList -}}
    {{- include "ix.v1.common.certificate.secret" (dict "cert" $cert "name" (required "Name is required in scaleCertList" $cert.name) "root" $root) -}}
  {{- end -}}
{{- end -}}
