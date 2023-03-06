{{- define "certmanager.clusterissuer.acme" -}}
{{- range .Values.clusterIssuer.ACME }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name }}
spec:
  acme:
    email: {{ .email }}
    server: {{ if eq .server "custom" }}{{ .customServer }}{{ else }}{{ .server }}{{ end }}
    privateKeySecretRef:
      name: {{ .name }}-acme-clusterissuer-account-key
    solvers:
    {{- if eq .type "HTTP01" }}
    - http01:
        ingress:
    {{- else }}
    - dns01:
      {{- if eq .type "cloudflare" }}
        cloudflare:
          email: {{ .email }}
         {{- if .cfapitoken }}
          apiTokenSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: cf-api-token
         {{- else if .cfapikey }}
          apiKeySecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: cf-api-key
         {{ else }}
         {{- fail "A cloudflare API key or token is required" }}
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
      {{- else if eq .type "akamai" }}
        akamai:
          serviceConsumerDomain: {{ .serviceConsumerDomain }}
          clientTokenSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: akclientToken
          clientSecretSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: akclientSecret
          accessTokenSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: akaccessToken
      {{- else if eq .type "digitalocean" }}
        digitalocean:
          tokenSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: doaccessToken
      {{- else if eq .type "rfc2136" }}
        rfc2136:
          nameserver: {{ .nameserver }}
          tsigKeyName: {{ .tsigKeyName }}
          tsigAlgorithm: {{ .tsigAlgorithm }}
          tsigSecretSecretRef:
            name: {{ .name }}-clusterissuer-secret
            key: rfctsigSecret
      {{- else }}
      {{- fail "No correct ACME type entered..." }}
      {{- end }}
    {{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}-clusterissuer-secret
type: Opaque
stringData:
  cf-api-token: {{ .cfapitoken | default "" }}
  cf-api-key: {{ .cfapikey | default "" }}
  route53-secret-access-key: {{ .route53SecretAccessKey | default "" }}
  akclientToken: {{ .akclientToken | default "" }}
  akclientSecret: {{ .akclientSecret | default "" }}
  akaccessToken: {{ .akaccessToken | default "" }}
  doaccessToken: {{ .doaccessToken | default "" }}
  rfctsigSecret: {{ .rfctsigSecret | default "" }}
{{- end }}
{{- end -}}
