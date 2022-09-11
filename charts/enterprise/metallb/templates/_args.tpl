{{/* Define the args */}}
{{- define "metallb.controller.args" -}}
args:
  {{/* merge all ports */}}
  - --port={{ .Values.service.main.ports.main.targetPort }}
  - --log-level={{ .Values.metallb.controller.logLevel }}
  - --cert-service-name={{ include "tc.common.names.fullname" . }}-webhook
  {{- if .Values.metallb.loadBalancerClass }}
  - --lb-class={{ .Values.metallb.loadBalancerClass }}
  {{- end }}
  {{- if .Values.metallb.controller.webhookMode }}
  - --webhook-mode={{ .Values.metallb.controller.webhookMode }}
  {{- end }}
{{- end -}}
