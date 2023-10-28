{{/*
This template serves as a blueprint for all Cert-Manager Certificate objects that are created
within the common library.
*/}}
{{- define "tc.v1.common.class.certificate" -}}
{{- $root := .root -}}
{{- $name := .name -}}
{{- $hosts := .hosts -}}
{{- $certificateIssuer := .certificateIssuer -}}
{{- $certificateSecretTemplate := .secretTemplate }}
---
apiVersion: {{ include "tc.v1.common.capabilities.cert-manager.certificate.apiVersion" $ }}
kind: Certificate
metadata:
  name: {{ $name }}
  namespace: {{ $root.Values.namespace | default $root.Values.global.namespace | default $root.Release.Namespace }}
spec:
  secretName: {{ $name }}
  dnsNames:
  {{- range $hosts }}
  - {{ tpl . $root | quote }}
  {{- end }}
  privateKey:
    algorithm: ECDSA
    size: 256
    rotationPolicy: Always
  issuerRef:
    name: {{ tpl $certificateIssuer $root | quote }}
    kind: ClusterIssuer
    group: cert-manager.io
  {{- if $certificateSecretTemplate }}
  secretTemplate:
    {{- $labels := (mustMerge ($certificateSecretTemplate.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $root | fromYaml)) -}}
    {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $root "labels" $labels) | trim) }}
    labels:
      {{- . | nindent 6 }}
    {{- end -}}
    {{- $annotations := (mustMerge ($certificateSecretTemplate.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $root | fromYaml)) -}}
    {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $root "annotations" $annotations) | trim) }}
    annotations:
      {{- . | nindent 6 }}
    {{- end -}}
  {{- end -}}

{{- end -}}
