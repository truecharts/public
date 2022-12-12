{{/*
Call this from other templates to create a Secret/k8s.tls.
Pass a "root" object and the "certID"
(certID comes from Scale's GUI definitions)
If you also pass a "key" when calling this spawner,
instead of creating a secret it will return you the value
of that key (if exists)
*/}}
{{- define "ix.v1.common.spawner.certificate" -}}
  {{- $key := (default "" .key) -}}
  {{- $root := . -}}

  {{- range $name, $cert := .Values.scaleCerts -}}
    {{- if not (hasKey $cert "id") -}}
      {{- fail (printf "Certificate (%s) has no <id> key" $name) -}}
    {{- end -}}
    {{- $certID := (toString $cert.id) -}}

    {{/* Default to $name if there is not a nameOverride given */}}
    {{- if not $cert.nameOverride -}}
      {{- $_ := set $cert "nameOverride" $name -}}
    {{- end -}}

    {{/* Generate secret name here so we can pass it to persistence if needed */}}
    {{- $secretName := include "ix.v1.common.names.fullname" $root -}}
    {{- if $cert.nameOverride -}}
      {{- $secretName = (printf "%v-%v-%v-%v" $secretName $cert.nameOverride "ixcert" $certID) -}}
    {{- else -}}
      {{- $secretName = (printf "%v-%v-%v" $secretName "ixcert" $certID) -}}
    {{- end -}}
    {{- $secretName = (printf "%v-%v" $secretName $root.Release.Revision) -}}

    {{/* Create the secret */}}
    {{- include "ix.v1.common.class.certificate" (dict "root" $root "certID" $certID "secretName" $secretName) -}}

    {{- if (hasKey $cert "certPath") -}}
      {{- if $cert.certPath -}}
        {{/* FIXME: Create Volume + Volume Mount of the certificate in the certPath */}}
        {{/* Probably append to .Values.persistence? Also make sure to call this spawner before pod creation */}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $cert "keyPath") -}}
      {{- if $cert.keyPath -}}
        {{/* FIXME: Create Volume + Volume Mount of the private key in the certPath */}}
        {{/* Probably append to .Values.persistence? Also make sure to call this spawner before pod creation */}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
