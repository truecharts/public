{{- define "certmanager.clusterissuer.clusterCertificates" -}}
  {{- if .Values.clusterCertificates -}}
    {{- $certs := dict -}}
    {{- $secretTemplates := dict -}}
    {{ $certNamespace := (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $ "objectData" $certs "caller" "ClusterCertificates")) -}}

    {{- $reflectorAnnotations := (dict
        "reflector.v1.k8s.emberstack.com/reflection-allowed" "true"
        "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" "true"
        "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" (printf "%v,%v" $certNamespace .Values.clusterCertificates.replicationNamespaces)
        "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces" .Values.clusterCertificates.replicationNamespaces) -}}
    {{- $certAnnotations := (mustMerge ($reflectorAnnotations) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) -}}

    {{- $_ := set $secretTemplates "annotations" $certAnnotations -}}

    {{- range .Values.clusterCertificates.certificates -}}
      {{- $_ := set $certs .name dict -}}
      {{- $currentCert := (index $certs (.name)) -}}
      {{- $_ := set $currentCert "enabled" .enabled -}}
      {{- $_ := set $currentCert "nameOverride" .name -}}
      {{- $_ := set $currentCert "hosts" .hosts -}}
      {{- $_ := set $currentCert "certificateIssuer" .certificateIssuer -}}
      {{- $_ := set $currentCert "secretTemplates" $secretTemplates -}}
    {{- end -}}

  {{- $_ := set .Values "cert" $certs }}
  {{/* Render the ClusterWide Certificate(s) */}}
  {{- include "tc.v1.common.spawner.certificate" . | nindent 0 -}}
  {{- end -}}
{{- end -}}

