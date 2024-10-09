{{/* Define the tlsOptions */}}
{{- define "traefik.tlsOptions" -}}
{{- range $name, $config := .Values.tlsOptions }}

---
apiVersion: traefik.io/v1alpha1
kind: TLSOption
metadata:
  name: {{ $name }}
spec:
  {{- toYaml $config | nindent 2 }}
{{- end }}
{{- end }}
