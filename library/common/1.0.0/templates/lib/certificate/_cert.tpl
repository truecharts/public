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
  {{- $certID := .certID -}}
  {{- $root := .root -}}
  {{- $key := .key -}}

  {{- if eq (include "ix.v1.common.certificate.exists" (dict "root" $root "certID" $certID)) "true" -}}
    {{- $certificate := (get $root.Values.ixCertificates (toString $certID)) -}}

    {{- if (hasKey $certificate "revoked") -}}
      {{- if eq (get $certificate "revoked") true -}}
        {{- fail (printf "Certificate (%s) has been revoked" $certID) -}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $certificate "expired") -}}
      {{- if eq (get $certificate "expired") true -}}
        {{- fail (printf "Certificate (%s) is expired" $certID) -}}
      {{- end -}}
    {{- end -}}

    {{- if (hasKey $certificate $key) -}}
      {{- get $certificate $key -}}
    {{- else -}}
      {{- fail (printf "Key (%s) does not exist in certificate (%s)" $key $certID) -}}
    {{- end -}}

  {{- else -}}
    {{- fail (printf "Certificate (%s) did not found." $certID) -}}
  {{- end -}}
{{- end -}}
