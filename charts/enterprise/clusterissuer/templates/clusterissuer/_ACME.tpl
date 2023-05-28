{{- define "certmanager.clusterissuer.acme" -}}
{{- range .Values.clusterIssuer.ACME }}
  {{- if not (mustRegexMatch "^[a-z]+(-?[a-z]){0,63}-?[a-z]+$" .name) -}}
    {{- fail "ACME - Expected name to be all lowercase with hyphens, but not start or end with a hyphen" -}}
  {{- end -}}
  {{- $validTypes := list "HTTP01" "cloudflare" "route53" "digitalocean" "akamai" "rfc2136" -}}
  {{- if not (mustHas .type $validTypes) -}}
    {{- fail (printf "Expected ACME type to be one of [%s], but got [%s]" (join ", " $validTypes) .type) -}}
  {{- end -}}
  {{- $issuerSecretName := printf "%s-clusterissuer-secret" .name }}
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
            name: {{ $issuerSecretName }}
            key: cf-api-token
         {{- else if .cfapikey }}
          apiKeySecretRef:
            name: {{ $issuerSecretName }}
            key: cf-api-key
         {{- else -}}
          {{- fail "A cloudflare API key or token is required" -}}
         {{- end -}}
      {{- else if eq .type "route53" }}
        route53:
          region: {{ .region }}
          accessKeyID: {{ .accessKeyID }}
          {{- if .role }}
          role: {{ .role }}
          {{- end }}
          secretAccessKeySecretRef:
            name: {{ $issuerSecretName }}
            key: route53-secret-access-key
      {{- else if eq .type "akamai" }}
        akamai:
          serviceConsumerDomain: {{ .serviceConsumerDomain }}
          clientTokenSecretRef:
            name: {{ $issuerSecretName }}
            key: akclientToken
          clientSecretSecretRef:
            name: {{ $issuerSecretName }}
            key: akclientSecret
          accessTokenSecretRef:
            name: {{ $issuerSecretName }}
            key: akaccessToken
      {{- else if eq .type "digitalocean" }}
        digitalocean:
          tokenSecretRef:
            name: {{ $issuerSecretName }}
            key: doaccessToken
      {{- else if eq .type "rfc2136" }}
        rfc2136:
          nameserver: {{ .nameserver }}
          tsigKeyName: {{ .tsigKeyName }}
          tsigAlgorithm: {{ .tsigAlgorithm }}
          tsigSecretSecretRef:
            name: {{ $issuerSecretName }}
            key: rfctsigSecret
      {{- end -}}
    {{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  namespace: cert-manager
  name: {{ $issuerSecretName }}
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
