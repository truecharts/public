{{- define "k8sgateway.container" -}}
enabled: true
imageSelector: k8sgatewayImage
securityContext:
  runAsUser: 0
  runAsGroup: 0
  readOnlyRootFilesystem: true
args: ["-conf", "/etc/coredns/Corefile"]
probes:
  readiness:
    enabled: true
    path: /ready
    port: 8181
  liveness:
    enabled: true
    path: /health
    port: 8080
  startup:
    enabled: true
    path: /ready
    port: 8181
{{- end -}}

{{/*
Create the matchable regex from domain
*/}}
{{- define "k8sgateway.configmap.regex" -}}
{{- if .dnsChallenge.domain }}
{{- .dnsChallenge.domain | replace "." "[.]" -}}
{{- else -}}
    {{ "unset" }}
{{- end }}
{{- end -}}

{{/* Define the configmap */}}
{{- define "k8sgateway.configmap" -}}
{{- $values := .Values.k8sgateway }}
{{- $fqdn := ( include "tc.v1.common.lib.chart.names.fqdn" . ) }}
enabled: true
data:
  Corefile: |
    .:{{ .Values.service.k8sgateway.ports.k8sgateway.targetPort }} {
        errors
        log
        health {
            lameduck 5s
        }
        ready
        {{- range .Values.k8sgateway.domains }}
        {{- if .dnsChallenge.enabled }}
          {{- if not .dnsChallenge.domain -}}
            {{- fail "DNS01 challenge domain is mandatory" -}}
          {{- end }}

        template IN ANY {{ required "Delegated domain ('domain') is mandatory" .domain }} {
           match "_acme-challenge[.](.*)[.]{{ include "k8sgateway.configmap.regex" . }}"
           {{- $name := "{{ \"{{ .Name }}\" }}" }}
           {{- $index := "{{ \"{{ index .Match 1 }}\" }}" }}
           answer "{{ $name }} 5 IN CNAME {{ $index }}.{{ .dnsChallenge.domain }}"
           fallthrough
        }
        {{- end }}
        {{- end }}
        k8s_gateway {{ range .Values.k8sgateway.domains }}"{{ required "Delegated domain ('domain') is mandatory " .domain }}"{{ end }} {
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

        prometheus 0.0.0.0:9153
        {{- if .Values.k8sgateway.forward.enabled }}
        forward . {{ .Values.k8sgateway.forward.primary }} {{ .Values.k8sgateway.forward.secondary }} {
          {{- range .Values.k8sgateway.forward.options }}
          {{ .name }} {{ .value }}
          {{- end }}
        }
        {{- else }}
        forward . 1.1.1.1
        {{- end }}
        loop
        reload
        loadbalance
    }
{{- end -}}
