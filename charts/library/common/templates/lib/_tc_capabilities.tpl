{{/* Return the appropriate apiVersion for PodMonitor */}}
{{- define "tc.v1.common.capabilities.podmonitor.apiVersion" -}}
  {{- print "monitoring.coreos.com/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for ServiceMonitor */}}
{{- define "tc.v1.common.capabilities.servicemonitor.apiVersion" -}}
  {{- print "monitoring.coreos.com/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for PrometheusRule */}}
{{- define "tc.v1.common.capabilities.prometheusrule.apiVersion" -}}
  {{- print "monitoring.coreos.com/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for NetworkPolicy*/}}
{{- define "tc.v1.common.capabilities.networkpolicy.apiVersion" -}}
  {{- print "networking.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for HorizontalPodAutoscaler aka HPA*/}}
{{- define "tc.v1.common.capabilities.hpa.apiVersion" -}}
  {{- print "autoscaling/v2" -}}
{{- end -}}
