{{- define "common.appIngress" -}}
{{- if .Values.appIngressEnabled -}}
{{- if .Values.appIngress.host -}}
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    traefik.ingress.kubernetes.io/router.entrypoints: {{ .Values.appIngress.entrypoint }}
    traefik.ingress.kubernetes.io/router.tls: "true"
    traefik.ingress.kubernetes.io/router.middlewares: traefik-middlewares-chain-public@kubernetescrd
    {{- if .Values.appIngress.authForwardUrl -}}
    traefik.ingress.kubernetes.io/router.middlewares: traefik-middlewares-{{ .Release.Name }}-auth-forward@kubernetescrd
    {{- end }}
  name: {{ .Release.Name }}
spec:
  rules:
  - host: {{ .Values.appIngress.host }}
    http:
      paths:
      - path: /
        backend:
          serviceName: {{ .Release.Name }}
          servicePort: {{.Values.appIngress.port}}
  tls: {{- if .Values.appIngress.selfsigned -}}{{ else if .Values.appIngress.existingCert }}
    secretName: {{ .Values.appIngress.existingCert }}
  {{ else if .Values.appIngress.wildcard }}
    secretName: wilddcardcert
  {{ else }}
  - hosts:
      - {{ .Values.appIngress.host }}
    secretName: {{ .Release.Name }}
  {{ end }}
{{- if .Values.appIngress.authForwardUrl -}}
---
# Forward authentication
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: {{ .Release.Name }}-auth-forward
  namespace: traefik-middlewares
spec:
  forwardAuth:
    address: '{{ .Values.appIngress.authForwardUrl }}'
    trustForwardHeader: true
    authResponseHeaders:
       - Remote-User
       - Remote-Groups
       - Remote-Name
       - Remote-Email
{{- end }}
{{- end }}
{{- end }}
{{- end }}