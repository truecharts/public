{{- define "certmanager.clusterissuer.clusterCertificates" -}}
{{- if .Values.clusterCertificates -}}
  {{- $rootCtx := . -}}
  {{- $certs := dict }}
  {{- $secretTemplates := dict }}

  {{ $certNamespace := .Values.namespace | default .Values.global.namespace | default .Release.Namespace }}

  {{- $reflectorAnnotations := (dict
      "reflector.v1.k8s.emberstack.com/reflection-allowed" "true"
      "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" "true"
      "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" (printf "%v,%v" $certNamespace .Values.clusterCertificates.replicationNamespaces)
      "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces" .Values.clusterCertificates.replicationNamespaces) }}
  {{- $certAnnotations := (mustMerge ($reflectorAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}

  {{- $_ := set $secretTemplates "annotations" $certAnnotations }}

  {{- range .Values.clusterCertificates.certificates }}
    {{- $_ := set $certs .name dict }}
    {{- $_ := set (index $certs (.name)) "enabled" .enabled }}
    {{- $_ := set (index $certs (.name)) "nameOverride" .name }}
    {{- $_ := set (index $certs (.name)) "hosts" .hosts }}
    {{- $_ := set (index $certs (.name)) "certificateIssuer" .certificateIssuer }}
    {{- $_ := set (index $certs (.name)) "secretTemplates" $secretTemplates }}
  {{- end -}}

{{- $_ := set .Values "cert" $certs }}
{{/* Render the ClusterWide Certificates(s) */}}
{{- include "tc.v1.common.spawner.certificate" . | nindent 0 -}}
{{- end }}
{{- end -}}

