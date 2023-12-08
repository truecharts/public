{{- define "certmanager.clusterissuer.clusterCertificates" -}}
  {{- if .Values.clusterCertificates -}}
    {{- $secretTemplates := dict -}}
    {{- $certNamespace := (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $ "objectData" dict "caller" "ClusterCertificates")) -}}
  {{- $replicationNamespaces := ".*" -}}
  {{- if .Values.clusterCertificates.replicationNamespaces -}}
    {{- $replicationNamespaces = .Values.clusterCertificates.replicationNamespaces -}}
  {{- else if .Values.ixChartContext -}}
    {{- $replicationNamespaces = "ix-.*" -}}
  {{- end -}}
    {{- $reflectorAnnotations := (dict
        "reflector.v1.k8s.emberstack.com/reflection-allowed" "true"
        "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" "true"
        "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" (printf "%v,%v" $certNamespace $replicationNamespaces)
        "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces" $replicationNamespaces ) -}}
    {{- $certAnnotations := (mustMerge ($reflectorAnnotations) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) -}}

    {{- $_ := set $secretTemplates "annotations" $certAnnotations -}}

    {{- if not $.Values.certificate -}}
      {{- $_ := set $.Values "certificate" dict -}}
    {{- end -}}

    {{- range .Values.clusterCertificates.certificates -}}
      {{- $_ := set $.Values.certificate .name (dict
        "enabled" .enabled
        "hosts" .hosts
        "certificateIssuer" .certificateIssuer
        "certificateSecretTemplate" $secretTemplates
      ) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
