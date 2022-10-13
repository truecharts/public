{{- define "k8sgateway.container" -}}
image: {{ .Values.k8sgatewayImage.repository }}:{{ .Values.k8sgatewayImage.tag }}
imagePullPolicy: {{ .Values.k8sgatewayImage.pullPolicy }}
securityContext:
  runAsUser: 0
  runAsGroup: 0
  readOnlyRootFilesystem: true
  runAsNonRoot: false
args: ["-conf", "/etc/coredns/Corefile"]
ports:
  - containerPort: {{ .Values.service.k8sgateway.ports.k8sgateway.targetPort }}
    name: main
volumeMounts:
  - name: config-volume
    mountPath: /etc/coredns
readinessProbe:
  httpGet:
    path: /ready
    port: 8181
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /ready
    port: 8181
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
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
    .:{{ .Values.service.k8sgateway.ports.k8sgateway.targetPort }} {
        errors
        log
        health {
            lameduck 5s
        }
        ready
        {{- range .Values.k8sgateway.domains }}
        {{- if .dnsChallenge.enabled }}
        template IN ANY {{ required "Delegated domain ('domain') is mandatory" .domain }} {
           match "_acme-challenge[.](.*)[.]{{ include "k8sgateway.configmap.regex" . }}"
           answer "{{ "{{" }} .Name {{ "}}" }} 5 IN CNAME {{ "{{" }}  index .Match 1 {{ "}}" }}.{{ required "DNS01 challenge domain is mandatory" .dnsChallenge.domain }}"
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
