{{- define "certmanager.clusterissuer.clusterCertificates" -}}
{{- if .Values.clusterCertificates -}}
  {{- $cert := (.Values.cert | default dict) }}
  {{- $secretTemplates := dict }}

  {{ $certNamespace := .Values.namespace | default .Values.global.namespace | default .Release.Namespace }}

  {{- $reflectorAnnotations := (dict
      "reflector.v1.k8s.emberstack.com/reflection-allowed" "true"
      "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" "true"
      "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" (printf "%v,%v" $certNamespace .Values.clusterCertificates.replicationNamespaces)
      "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces" .Values.clusterCertificates.replicationNamespaces) }}
  {{- $certAnnotations := (mustMerge ($reflectorAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}

  {{- $_ := set $secretTemplates "annotations" $certAnnotations }}

  {{- range $_, $certValues := .Values.clusterCertificates.certificates }}
    {{- $_ := set $cert $certValues.name dict }}
    {{- $_ := set (index $cert ($certValues.name)) "hosts" $certValues.hosts }}
    {{- $_ := set (index $cert ($certValues.name)) "certificateIssuer" $certValues.certificateIssuer }}
    {{- $_ := set (index $cert ($certValues.name)) "secretTemplates" $secretTemplates }}
  {{- end -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  {{- $cert := (.Values.cert | default dict) }}
  {{ .Values.clusterCertificates.certificates | toYaml | nindent 2}}
{{- end }}
{{- end -}}

