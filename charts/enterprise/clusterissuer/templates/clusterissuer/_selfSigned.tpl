{{- define "certmanager.clusterissuer.selfsigned" -}}
{{- if .Values.clusterIssuer.selfSigned.enabled -}}
  {{- if not (mustRegexMatch "^[a-z]+(-?[a-z]){0,63}-?[a-z]+$" .Values.clusterIssuer.selfSigned.name) -}}
    {{- fail "Self Singed Issuer - Expected name to be all lowercase with hyphens, but not start or end with a hyphen" -}}
  {{- end }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .Values.clusterIssuer.selfSigned.name }}
spec:
  selfSigned: {}
{{- end }}
{{- end -}}
