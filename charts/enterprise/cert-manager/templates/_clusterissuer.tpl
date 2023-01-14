{{- define "certmanager.clusterissuer" -}}
{{- range .Values.clusterIssuer }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name }}-clusterissuer
spec:
  acme:
    email: {{ .email }}
    server: {{ .server }}
    privateKeySecretRef:
      name: {{ .name }}-clusterissuer-account-key
    solvers:
	{{- if -eq .type "cloudflare" }}
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
	{{- end }}
	
{{- if -eq .type "cloudflare" }}
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
