{{- define "ix.v1.common.class.certificate" -}}
  {{- $secretName := .secretName -}}
  {{- $certName := .certName -}}
  {{- $root := .root -}}

  {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certName" $certName)) }}
---
apiVersion: {{ include "ix.v1.common.capabilities.secret.apiVersion" . }}
kind: Secret
type: kubernetes.io/tls
metadata:
  name: {{ $secretName }}
  {{- $labels := (default dict (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (default dict (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
data:
  tls.crt: {{ include "ix.v1.common.certificate.get" (dict "root" $root "certName" $certName "key" "certificate") | toString | b64enc | quote }}
  tls.key: {{ include "ix.v1.common.certificate.get" (dict "root" $root "certName" $certName "key" "privatekey") | toString | b64enc | quote }}
  {{- end -}}
{{- end -}}
