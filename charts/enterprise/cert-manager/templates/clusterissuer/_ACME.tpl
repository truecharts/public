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
    {{- if eq .type "HTTP01" }}
    {{- else }}

    - dns01:
      {{- if eq .type "cloudflare" }}
        cloudflare:
          email: {{ .email }}
         {{- if .cfapitoken }}
          apiTokenSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: cf-api-token
         {{- else .cfapikey }}
            name: {{ .name }}-clusterissuer-secret
            key: cf-api-key
         {{- end }}
      {{- else if eq .type "route53" }}
        route53:
          region: {{ .region }}
          accessKeyID: {{ .accessKeyID }}
          {{- if .role }}
          role: {{ .role }}
          {{- end }}
          secretAccessKeySecretRef:
            name: prod-route53-credentials-secret
            key: route53-secret-access-key
    {{- end }}


---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}-clusterissuer-secret
type: Opaque
stringData:
  cf-api-token: {{ .cfapitoken || default "" }}
  cf-api-key: {{ .cfapikey || default "" }}
  route53-secret-access-key: {{ .route53SecretAccessKey || default "" }}
{{- end }}
{{- end -}}
