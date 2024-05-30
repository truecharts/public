{{/*
Construct the path for the providers.kubernetesingress.ingressendpoint.publishedservice.
By convention this will simply use the <namespace>/<service-name> to match the name of the
service generated.
Users can provide an override for an explicit service they want bound via `.Values.providers.kubernetesIngress.publishedService.pathOverride`
*/}}
{{- define "providers.kubernetesIngress.publishedServicePath" -}}
{{- $fullName := include "tc.v1.common.lib.chart.names.fullname" . -}}
{{- $defServiceName := printf "%s/%s-tcp" .Release.Namespace $fullName -}}
{{- $servicePath := default $defServiceName .Values.providers.kubernetesIngress.publishedService.pathOverride }}
{{- print $servicePath | trimSuffix "-" -}}
{{- end -}}

{{/*
Construct a comma-separated list of whitelisted namespaces
*/}}
{{- define "providers.kubernetesIngress.namespaces" -}}
{{- default .Release.Namespace (join "," .Values.providers.kubernetesIngress.namespaces) }}
{{- end -}}
{{- define "providers.kubernetesCRD.namespaces" -}}
{{- default .Release.Namespace (join "," .Values.providers.kubernetesCRD.namespaces) }}
{{- end -}}
