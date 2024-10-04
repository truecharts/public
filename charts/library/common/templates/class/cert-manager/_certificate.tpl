{{/* Certificate Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.certificate" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the certificate.
  labels: The labels of the certificate.
  annotations: The annotations of the certificate.
  namespace: The namespace of the certificate. (Optional)
*/}}
{{- define "tc.v1.common.class.certificate" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}

---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Cert Manager Certificate") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  secretName: {{ $objectData.name }}
  dnsNames:
  {{- range $h := $objectData.hosts }}
    - {{ (tpl $h $rootCtx) | quote }}
  {{- end }}
  privateKey:
    algorithm: ECDSA
    size: 256
    rotationPolicy: Always
  issuerRef:
    name: {{ tpl $objectData.certificateIssuer $rootCtx }}
    kind: ClusterIssuer
    group: cert-manager.io
  {{- if $objectData.certificateSecretTemplate }}
  secretTemplate:
    {{- $labels := (mustMerge ($objectData.certificateSecretTemplate.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
    {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
    labels:
      {{- . | nindent 6 }}
    {{- end -}}
    {{- $annotations := (mustMerge ($objectData.certificateSecretTemplate.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
    {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
    annotations:
      {{- . | nindent 6 }}
    {{- end -}}
  {{- end -}}
{{- end -}}
