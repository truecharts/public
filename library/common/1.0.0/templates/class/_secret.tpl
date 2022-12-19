{{- define "ix.v1.common.class.secret" -}}
  {{- $secretName := .secretName -}}
  {{- $data := .data -}}
  {{- $type := .type -}}
  {{- $secretLabels := .labels -}}
  {{- $secretAnnotations := .annotations -}}
  {{- $root := .root -}}

  {{- $typeClass := "" -}}
  {{- if eq $type "certificate" -}}
    {{- $typeClass = (include "ix.v1.common.capabilities.secret.certificate.type" $root) -}}
  {{- else if eq $type "pullSecret" -}}
    {{- $typeClass = (include "ix.v1.common.capabilities.secret.imagePullSecret.type" $root) -}}
  {{- else -}}
    {{- $typeClass = "Opaque" -}}
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
  {{- if (mustHas $type (list "pullSecret" "certificate" "key_value")) }}
data:
  {{- else if (mustHas $type (list "scalar")) }}
stringData:
  {{- end -}}
  {{- if eq $type "pullSecret" }}
  .dockerconfigjson: {{ $data | toJson | b64enc }}
  {{- else if or (eq $type "certificate") (eq $type "key_value") }}
    {{- range $k, $v := $data }}
      {{- $k | nindent 2 }}: {{ $v | toString | b64enc }}
    {{- end -}}
  {{- else if eq $type "scalar" }}
    {{- $data | nindent 2 }}
  {{- else -}}
    {{- fail (printf "Invalid type (%s) for secret. Valid types are pullSecret, certificate, scalar and key_value" $type) -}}
  {{- end -}}
{{- end -}}
{{/* TODO: Unit tests */}}
