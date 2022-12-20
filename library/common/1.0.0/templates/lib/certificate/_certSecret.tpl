{{- define "ix.v1.common.certificate.secret" -}}
  {{- $name := .name -}}
  {{- $cert := .cert -}}
  {{- $root := .root -}}
  {{- $tlsCrtKey := "tls.crt" -}}
  {{- $tlsPrivateKey := "tls.key" -}}


  {{- if ne $name ($name | lower) -}}
    {{- fail (printf "Certificate has invalid name (%s). Name must be lowercase." $name) -}}
  {{- end -}}
  {{- if contains "_" $name -}}
    {{- fail (printf "Certificate has invalid name (%s). Name cannot contain underscores (_)" $name) -}}
  {{- end -}}

  {{/* Default to $name if there is not a nameOverride given */}}
  {{- if not $cert.nameOverride -}}
    {{- $_ := set $cert "nameOverride" $name -}}
  {{- end -}}

  {{- if not (hasKey $cert "id") -}} {{/* This is something that should not happen when using this library */}}
    {{- fail (printf "Certificate (%s) has no <id> key" $cert.nameOverride) -}}
  {{- end -}} {{/* It can only happen when consuing this function within this library */}}
  {{- $certID := (toString $cert.id) -}}

  {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certID" $certID)) -}}
    {{/* Generate secret name here so we can pass it to persistence if needed */}}
    {{- $secretName := include "ix.v1.common.names.fullname" $root -}}
    {{- if $cert.nameOverride -}}
      {{- $secretName = (printf "%v-%v-%v-%v" $secretName $cert.nameOverride "ixcert" $certID) -}}
    {{- else -}}
      {{- $secretName = (printf "%v-%v-%v" $secretName "ixcert" $certID) -}}
    {{- end -}}
    {{- $secretName = (printf "%v-%v" $secretName $root.Release.Revision) -}}

    {{- include "ix.v1.common.certificate.persistence" (dict "root" $root "secretName" $secretName "cert" $cert "certID" $certID "tlsKey" $tlsCrtKey "type" "cert") -}}
    {{- include "ix.v1.common.certificate.persistence" (dict "root" $root "secretName" $secretName "cert" $cert "certID" $certID "tlsKey" $tlsPrivateKey "type" "key") -}}

    {{- $certData := dict -}}
    {{- $_ := set $certData $tlsCrtKey (include "ix.v1.common.certificate.get" (dict "root" $root "cert" $cert "key" "certificate")) -}}
    {{- $_ := set $certData $tlsPrivateKey (include "ix.v1.common.certificate.get" (dict "root" $root "cert" $cert "key" "privatekey")) -}}

    {{/* Create the Secret */}}
    {{- include "ix.v1.common.class.secret" (dict "root" $root "secretName" $secretName "data" $certData "contentType" "certificate") -}}
  {{- end -}}
{{- end -}}
