{{- define "certmanager.clusterissuer.ca" -}}
{{- range .Values.clusterIssuer.CA }}
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
  namespace: cert-manager
spec:
  isCA: true
  commonName: {{ .selfSignedCommonName }}
  secretName: {{ .name }}-ca
  privateKey:
    algorithm: ECDSA
    size: 256
  issuerRef:
    name: selfsigned-ca-issuer
    kind: ClusterIssuer
    group: cert-manager.io
{{- else }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}-ca
  namespace: cert-manager
data:
  tls.crt: {{ .crt | b64enc }}
  tls.key: {{ .key | b64enc }}
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
