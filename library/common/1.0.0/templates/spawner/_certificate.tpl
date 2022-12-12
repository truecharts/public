{{/*
Call this from other templates to create a Secret/k8s.tls.
Pass a "root" object and the "certID"
(certID comes from Scale's GUI definitions)
If you also pass a "key" when calling this spawner,
instead of creating a secret it will return you the value
of that key (if exists)
*/}}
{{- define "ix.v1.common.spawner.certificate" -}}
  {{- $root := . -}}

  {{- range $name, $cert := .Values.scaleCerts -}}
    {{- include "ix.v1.common.certificate.process" (dict "cert" $cert "name" $name "root" $root) -}}
  {{- end -}}

  {{- range $id, $cert := .Values.scaleCertsList -}}
    {{- include "ix.v1.common.certificate.process" (dict "cert" $cert "name" (required "Name is required in scaleCertList" $cert.name) "root" $root) -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.certificate.process" -}}
  {{- $name := .name -}}
  {{- $cert := .cert -}}
  {{- $root := .root -}}

  {{/* Default to $name if there is not a nameOverride given */}}
  {{- if not $cert.nameOverride -}}
    {{- $_ := set $cert "nameOverride" $name -}}
  {{- end -}}

  {{/* Create the secret */}}
  {{- include "ix.v1.common.class.certificate" (dict "cert" $cert "root" $root) -}}
{{- end -}}
