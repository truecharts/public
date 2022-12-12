{{/*
When a cert is selected in the GUI,
middleware adds it as dict in ixCertificates.
This checks that the certName exists as a key/dict.
 */}}
{{- define "ix.v1.common.certificate.exists" -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}

  {{- if hasKey $root.Values "ixCertificates" -}}
    {{- if $root.Values.ixCertificates -}}
      {{- hasKey $root.Values.ixCertificates (toString $certName) -}}
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
  {{- $certName := .certName -}}
  {{- $root := .root -}}
  {{- $key := .key -}}

  {{- if eq (include "ix.v1.common.certificate.exists" (dict "root" $root "certName" $certName)) "true" -}}
    {{- $certificate := (get $root.Values.ixCertificates (toString $certName)) -}}

    {{- if (hasKey $certificate "revoked") -}}
      {{- if eq (get $certificate "revoked") true -}}
        {{- fail (printf "Certificate (%s) has been revoked" $certName) -}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $certificate "expired") -}}
      {{- if eq (get $certificate "expired") true -}}
        {{- fail (printf "Certificate (%s) is expired" $certName) -}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $certificate $key) -}}
      {{- get $certificate $key -}}
    {{- else -}}
      {{- fail (printf "Key (%s) does not exist in certificate (%s)" $key $certName) -}}
    {{- end -}}

  {{- else -}}
    {{- fail (printf "Certificate (%s) did not found." $certName) -}}
  {{- end -}}
{{- end -}}
