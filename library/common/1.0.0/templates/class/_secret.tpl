{{- define "ix.v1.common.class.secret" -}}
  {{- $secretName := .secretName -}}
  {{- $data := .data -}}
  {{- $contentType := .contentType -}}
  {{- $secretType := .secretType -}}
  {{- $secretLabels := .labels -}}
  {{- $secretAnnotations := .annotations -}}
  {{- $root := .root -}}

  {{- $typeClass := "Opaque" -}}
  {{- if eq $contentType "certificate" -}}
    {{- $typeClass = (include "ix.v1.common.capabilities.secret.certificate.type" $root) -}}
  {{- else if eq $contentType "pullSecret" -}}
    {{- $typeClass = (include "ix.v1.common.capabilities.secret.imagePullSecret.type" $root) -}}
  {{- end -}}

  {{- if $secretType -}} {{/* If custom type is defined */}}
    {{- $typeClass = $secretType -}}
  {{- end }}
---
apiVersion: {{ include "ix.v1.common.capabilities.secret.apiVersion" $root }}
kind: Secret
type: {{ $typeClass }}
metadata:
  name: {{ $secretName }}
  {{- $labels := (mustMerge ($secretLabels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($secretAnnotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
  {{- if (mustHas $contentType (list "pullSecret" "certificate" "key_value")) }}
data:
  {{- else if (mustHas $contentType (list "scalar")) }}
stringData:
  {{- end -}}
  {{- if eq $contentType "pullSecret" }}
  .dockerconfigjson: {{ $data | toJson | b64enc }}
  {{- else if or (eq $contentType "certificate") (eq $contentType "key_value") }}
    {{- range $k, $v := $data }}
      {{- $k | nindent 2 }}: {{ $v | toString | b64enc }}
    {{- end -}}
  {{- else if eq $contentType "scalar" }}
    {{- $data | nindent 2 }}
  {{- else -}}
    {{- fail (printf "Invalid content type (%s) for secret. Valid types are pullSecret, certificate, scalar and key_value" $contentType) -}}
  {{- end -}}
{{- end -}}
{{/* TODO: Unit tests */}}
