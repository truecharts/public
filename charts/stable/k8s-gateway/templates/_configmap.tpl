{{/*
Create the matchable regex from domain
*/}}
{{- define "k8s-gateway.configmap.regex" -}}
{{- if .Values.domain }}
{{- .Values.domain | replace "." "[.]" -}}
{{- else -}}
    {{ "unset" }}
{{- end }}
{{- end -}}

{{/* Define the configmap */}}
{{- define "k8s-gateway.configmap" -}}
{{- $values := .Values }}
{{- $fqdn := ( include "tc.common.names.fqdn" . ) }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-corefile
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  Corefile: |-
    .:53 {
        errors
        log
        health {
            lameduck 5s
        }
        ready
        {{- range .Values.domains }}
        {{- if .dnsChallenge.enabled }}
        template IN ANY {{ required "Delegated domain ('domain') is mandatory " .domain }} {
           match "_acme-challenge[.](.*)[.]{{ include "k8s-gateway.configmap.regex" . }}"
           answer "{{ "{{" }} .Name {{ "}}" }} 5 IN CNAME {{ "{{" }}  index .Match 1 {{ "}}" }}.{{ required "DNS01 challenge domain is mandatory " $values.dnsChallenge.domain }}"
           fallthrough
        }
        {{- end }}
        k8s_gateway "{{ required "Delegated domain ('domain') is mandatory " .domain }}" {
          apex {{ $values.apex | default $fqdn }}
          ttl {{ $values.ttl }}
          {{- if $values.secondary }}
          secondary {{ $values.secondary }}
          {{- end }}
          {{- if $values.watchedResources }}
          resources {{ join " " $values.watchedResources }}
          {{- end }}
          fallthrough
        }
        {{- end }}
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
