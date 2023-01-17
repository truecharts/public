{{- define "certmanager.clusterissuer.ACME" -}}
{{- range .Values.clusterIssuer.ACME }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name }}-clusterissuer
spec:
  acme:
    email: {{ .email }}
    server: {{ if eq .server "custom" }}{{ .customServer }}{{ else }}{{ .server }}{{ end }}
    privateKeySecretRef:
      name: {{ .name }}-clusterissuer-account-key
    solvers:
    {{- if eq .type "cloudflare" }}
    - dns01:
        cloudflare:
          email: {{ .email }}
         {{- if .cfapitoken }}
          apiTokenSecretRef:
          name: {{ .name }}-clusterissuer-cloudflare
          key: api-token
         {{- else .cfapikey }}
          name: {{ .name }}-clusterissuer-cloudflare
          key: api-key
         {{- end }}
    {{- else if eq .type "HTTP01" }}
    {{- end }}

{{- if eq .type "cloudflare" }}
---
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-key-secret
type: Opaque
stringData:
  api-token: {{ .cfapitoken }}
  api-key: {{ .cfapikey }}
{{- end }}
{{- end }}
{{- end -}}
