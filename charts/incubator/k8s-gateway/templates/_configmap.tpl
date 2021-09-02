{{/*
Create the matchable regex from domain
*/}}
{{- define "k8s-gateway.configmap.regex" -}}
{{- if .Values.domain -}}
{{- .Values.domain | replace "." "[.]" -}}
{{- else -}}
    {{ "unset" }}
{{- end -}}
{{- end -}}

{{/* Define the configmap */}}
{{- define "k8s-gateway.configmap" -}}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . -}}-corefile
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  Corefile: |-
    .:53 {
        errors
        log
        health {
            lameduck 5s
        }
        ready
        {{- if .Values.dnsChallenge.enabled }}
        template IN ANY {{ required "Delegated domain ('domain') is mandatory " .Values.domain }} {
           match "_acme-challenge[.](.*)[.]{{ include "k8s-gateway.configmap.regex" . }}"
           answer "{{ "{{" }} .Name {{ "}}" }} 5 IN CNAME {{ "{{" }}  index .Match 1 {{ "}}" }}.{{ required "DNS01 challenge domain is mandatory " .Values.dnsChallenge.domain }}"
           fallthrough
        }
        {{- end }}
        k8s_gateway "{{ required "Delegated domain ('domain') is mandatory " .Values.domain }}" {
          apex {{ .Values.apex | default (include "common.names.fqdn" .) }}
          ttl {{ .Values.ttl }}
          {{- if .Values.secondary }}
          secondary {{ .Values.secondary }}
          {{- end }}
          {{- if .Values.watchedResources }}
          resources {{ join " " .Values.watchedResources }}
          {{- end }}
        }
        prometheus 0.0.0.0:9153
        {{- if .Values.forward.enabled }}
        forward . {{ .Values.forward.primary }} {{ .Values.forward.secondary }} {
          {{- range .Values.forward.options }}
          {{ .name }} {{ .value }}
          {{- end }}
        }
        {{- end }}
        loop
        reload
        loadbalance
    }
{{- end -}}
