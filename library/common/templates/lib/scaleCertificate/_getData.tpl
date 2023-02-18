{{/* Get Certificate Data */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.scaleCertificate.getData" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The object data of the certificate
*/}}
{{- define "tc.v1.common.lib.scaleCertificate.getData" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $certID := (toString $objectData.id) -}}

  {{/* Make sure certificate exists */}}
  {{- if hasKey $rootCtx.Values "ixCertificates" -}}
    {{- if not $rootCtx.Values.ixCertificates -}}
      {{- fail "Certificate - Expected non-empty <ixCertificates>" -}}
    {{- end -}}

    {{- if not (hasKey $rootCtx.Values.ixCertificates $certID) -}}
      {{- fail (printf "Certificate - Expected certificate with <id> [%q] to exist in <ixCertificates>" $certID) -}}
    {{- end -}}
  {{- end -}}

  {{- $data :=  get $rootCtx.Values.ixCertificates $certID -}}

  {{- range $flag := (list "revoked" "expired") -}}
    {{- if (get $data $flag) -}}
      {{- fail (printf "Certificate - Expected non-%s certificate with <id> [%q]" $flag $certID) -}}
    {{- end -}}
  {{- end -}}

  {{- range $key := (list "certificate" "privatekey") -}}
    {{- if not (get $data $key) -}}
      {{- fail (printf "Certificate - Expected non-empty [%s] in certificate with <id> [%q] in <ixCertificates>" $key $certID) -}}
    {{- end -}}
  {{- end -}}


  {{- $data | toJson -}}
{{- end -}}
