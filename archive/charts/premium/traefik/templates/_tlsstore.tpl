{{/* Define the tlsOptions */}}
{{- define "traefik.tlsstore" -}}
{{- if .Values.defaultCertificate }}
---
apiVersion: traefik.io/v1alpha1
kind: TLSStore
metadata:
  name: default
spec:
  certificates:
    - secretName: certificate-issuer-{{ tpl .Values.defaultCertificate $ }}
  defaultCertificate:
    secretName: certificate-issuer-{{ tpl .Values.defaultCertificate $ }}
{{- end }}

{{- range $name, $config := .Values.tlsStore }}

---
apiVersion: traefik.io/v1alpha1
kind: TLSStore
metadata:
  name: {{ $name }}
spec:
  {{- toYaml $config | nindent 2 }}
{{- end }}
{{- end }}
