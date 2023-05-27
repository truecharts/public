{{/* Define the configmap */}}
{{- define "pihole.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: pihole-env
data:
  WEBPASSWORD: {{ .Values.pihole.WEBPASSWORD | squote }}
  {{- if .Values.pihole.DNS1 }}
  "PIHOLE_DNS_": {{ if .Values.pihole.DNS2 }}{{ ( printf "%v;%v" .Values.pihole.DNS1 .Values.pihole.DNS2 ) | squote }}{{ else }}{{ .Values.pihole.DNS1 | squote }}{{ end }}
  {{- end }}
{{- end -}}
