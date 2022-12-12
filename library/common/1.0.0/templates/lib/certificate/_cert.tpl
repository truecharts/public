{{/*
When a cert is selected in the GUI,
middleware adds it as dict in ixCertificates.
This checks that the certID exists as a key/dict.
 */}}
{{- define "ix.v1.common.certificate.exists" -}}
  {{- $certID := .certID -}}
  {{- $root := .root -}}

  {{- if hasKey $root.Values "ixCertificates" -}}
    {{- if $root.Values.ixCertificates -}}
      {{- hasKey $root.Values.ixCertificates (toString $certID) -}}
    {{- else -}}
      {{- fail "Key <ixCertificates> is empty" -}}
    {{- end -}}
  {{- else -}}
    {{- fail "Key <ixCertificates> does not exist" -}}
  {{- end -}}
{{- end -}}

{{/*
Returns any key (based on the .key value)
Example keys (certificate, privatekey, expired, revoked)
*/}}
{{- define "ix.v1.common.certificate.get" -}}
  {{- $cert := .cert -}}
  {{- $root := .root -}}
  {{- $key := .key -}}
  {{- $certID := (toString $cert.id) -}}
  {{- $useRevoked := $root.Values.global.defaults.useRevokedCerts -}}
  {{- $useExpired := $root.Values.global.defaults.useExpiredCerts -}}

  {{- if not $key -}} {{/* This is something that should not happen when using this library */}}
    {{- fail "You need to provide a <key> when calling this template (certificate.get)" -}}
  {{- end -}} {{/* It can only happen when consuing this function within this library */}}

  {{- if eq (include "ix.v1.common.certificate.exists" (dict "root" $root "certID" $certID)) "true" -}}
    {{- $certificate := (get $root.Values.ixCertificates (toString $certID)) -}}

    {{- if (hasKey $cert "useRevoked") -}}
      {{- $useRevoked = $cert.useRevoked -}}
    {{- end -}}

    {{- if (hasKey $cert "useExpired") -}}
      {{- $useExpired = $cert.useExpired -}}
    {{- end -}}

    {{- if (hasKey $certificate "revoked") -}}
      {{- if (eq (get $certificate "revoked") true) -}}
        {{- if not $useRevoked -}}
          {{- fail (printf "Certificate (%s) has been revoked" $certID) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $certificate "expired") -}}
      {{- if (eq (get $certificate "expired") true) -}}
        {{- if not $useExpired -}}
          {{- fail (printf "Certificate (%s) is expired" $certID) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $certificate $key) -}}
      {{- get $certificate $key -}}
    {{- else -}} {{/* This is something that should not happen when using this library */}}
      {{- fail (printf "Key (%s) does not exist in certificate (%s)" $key $certID) -}}
    {{- end -}} {{/* It can only happen when consuing this function within this library */}}

  {{- else -}}
    {{- fail (printf "Certificate (%s) was not found." $certID) -}}
  {{- end -}}
{{- end -}}
