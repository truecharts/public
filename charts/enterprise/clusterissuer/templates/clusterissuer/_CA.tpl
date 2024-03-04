{{- define "certmanager.clusterissuer.ca" -}}
{{- $operator := index $.Values.operator "cert-manager" -}}
{{- $namespace := $operator.namespace | default "cert-manager" -}}

{{- range .Values.clusterIssuer.CA }}
  {{- if not (mustRegexMatch "^[a-z]+(-?[a-z]){0,63}-?[a-z]+$" .name) -}}
    {{- fail "CA - Expected name to be all lowercase with hyphens, but not start or end with a hyphen" -}}
  {{- end -}}
{{- if .selfSigned }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name }}-selfsigned-ca-issuer
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ .name }}-selfsigned-ca
  namespace: {{ $namespace }}
spec:
  isCA: true
  commonName: {{ .selfSignedCommonName }}
  secretName: {{ .name }}-ca
  privateKey:
    algorithm: ECDSA
    size: 256
  issuerRef:
    name: {{ .name }}-selfsigned-ca-issuer
    kind: ClusterIssuer
    group: cert-manager.io
{{- else }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}-ca
  namespace: {{ $namespace }}
data:
  tls.crt: {{ .crt | replace " CERTIFICATE" "_CERTIFICATE" | replace " " "\n" | replace "_CERTIFICATE" " CERTIFICATE" | b64enc }}
  tls.key: {{ .key | replace " PRIVATE KEY" "_PRIVATE_KEY" | replace " " "\n" | replace "_PRIVATE_KEY" " PRIVATE KEY" | b64enc }}
{{- end }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name }}
spec:
  ca:
    secretName: {{ .name }}-ca
{{- end }}
{{- end -}}
