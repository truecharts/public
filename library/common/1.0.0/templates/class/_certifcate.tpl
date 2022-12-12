{{- define "ix.v1.common.class.certificate" -}}
  {{- $secretName := include "ix.v1.common.names.fullname" . -}}
  {{- $root := .root -}}

  {{- $certName := .certName -}}
  {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certName" $certName)) -}}
  {{- if .key -}}
    {{- include "ix.v1.common.certificate.get" (dict "root" $root "certName" $certName "key" "certificate") -}}
  {{- else }}
---
apiVersion: {{ include "ix.v1.common.capabilities.secret.apiVersion" . }}
kind: Secret
type: kubernetes.io/tls
metadata:
  name: {{ printf "%s-%s" $secretName .Release.Revision }}
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
  tls.crt: {{ include "ix.v1.common.certificate.get" (dict "root" $root "certName" $certName "key" "certificate") }}
  tls.key: {{ include "ix.v1.common.certificate.get" (dict "root" $root "certName" $certName "key" "privatekey") }}
  {{- end -}}
{{- end -}}
