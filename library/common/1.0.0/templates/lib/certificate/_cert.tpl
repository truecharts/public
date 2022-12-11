{{/*
When a cert is selected in the GUI,
middleware adds it as dict in ixCertificates.
This checks that the certName exists as a key/dict.
 */}}
{{- define "ix.v1.common.certificate.exists" -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}

  {{- hasKey $root.Values.ixCertificates (toString $certName) -}}
{{- end -}}

{{/*
Returns the certificate
*/}}
{{- define "ix.v1.common.certificate.cert" -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}
  {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certName" $certName)) -}}
    {{- $certificate := (get $root.Values.ixCertificates (toString $certName)) -}}
    {{- $certificate.certificate -}}
  {{- else -}}
    {{ fail (printf "Certificate (%s) did not found." $certName) }}
  {{- end -}}
{{- end -}}

{{/*
Returns the privateKey
*/}}
{{- define "ix.v1.common.certificate.privatekey" -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}
  {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certName" $certName)) -}}
    {{- $privateKey := (get $root.Values.ixCertificates (toString $certName)) -}}
    {{- $privateKey.privatekey -}}
  {{- else -}}
    {{ fail (printf "Certificate (%s) did not found." $certName) }}
  {{- end -}}
{{- end -}}
