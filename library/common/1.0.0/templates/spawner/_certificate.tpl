{{/*
Call this from other templates to create a Secret/k8s.tls.
Pass a "root" object and the "certName"
(certName comes from Scale's GUI definitions)
If you also pass a "key" when calling this spawner,
instead of creating a secret it will return you the value
of that key (if exists)
*/}}
{{- define "ix.v1.common.spawner.certificate" -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}
  {{- $key := (default "" .key) -}}
  {{- $nameOverride := (default "" .nameOverride) -}}

  {{- $secretName := include "ix.v1.common.names.fullname" $root -}}

  {{- if .nameOverride -}}
    {{- $secretName = (printf "%v-%v-%v-%v" $secretName .nameOverride "ixcert" $certName) -}}
  {{- else -}}
    {{- $secretName = (printf "%v-%v-%v" $secretName "ixcert" $certName) -}}
  {{- end -}}

  {{- $secretName = (printf "%v-%v" $secretName $root.Release.Revision) -}}

  {{- if .key -}}
    {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certName" $certName)) -}}
      {{- include "ix.v1.common.certificate.get" (dict "root" $root "certName" $certName "key" .key) -}}
    {{- end -}}
  {{- else -}}
    {{- include "ix.v1.common.class.certificate" (dict "root" $root "certName" $certName "secretName" $secretName) -}}
  {{- end -}}
{{- end -}}
