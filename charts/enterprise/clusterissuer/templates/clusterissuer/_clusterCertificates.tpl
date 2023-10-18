{{- define "certmanager.clusterissuer.clusterCertificates" -}}
{{- if .Values.clusterCertificates -}}
  # TODO:
  # {{- range $index, $certValues := $Values.clusterCertificates }}

  # {{- end -}}

  # {{- include "tc.v1.common.class.certificate" (dict "root" $ "name" ( printf "%v-%v" $ingressName $tlsName ) "certificateIssuer" $tlsValues.certificateIssuer "hosts" $tlsValues.hosts ) -}}
  # {{- include "tc.v1.common.spawner.certificate" . | nindent 0 -}}

  # {{- if not (mustRegexMatch "^[a-z]+(-?[a-z]){0,63}-?[a-z]+$" .Values.clusterIssuer.selfSigned.name) -}}
  #   {{- fail "Self Singed Issuer - Expected name to be all lowercase with hyphens, but not start or end with a hyphen" -}}
  # {{- end }}
{{- end }}
{{- end -}}
