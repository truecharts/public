{{- define "ix.v1.common.class.configmap" -}}
  {{- $configName := .configName -}}
  {{- $data := .data -}}
  {{- $contentType := .contentType -}}
  {{- $configLabels := .labels -}}
  {{- $configAnnotations := .annotations -}}
  {{- $root := .root }}

---
apiVersion: {{ include "ix.v1.common.capabilities.configMap.apiVersion" $root }}
kind: ConfigMap
metadata:
  name: {{ $configName }}
  {{- $labels := (mustMerge ($configLabels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($configAnnotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
data:
  {{- if eq $contentType "key_value" -}}
    {{- range $k, $v := $data }}
      {{- $k | nindent 2 }}: {{ $v | quote }}
    {{- end -}}
  {{- else if eq $contentType "scalar" }}
    {{- $data | nindent 2 }}
  {{- else -}} {{/* This should never happen, unless there is a mistake in the caller of this class */}}
    {{- fail (printf "Invalid content type (%s) for configmap. Valid types are scalar and key_value" $contentType) -}}
  {{- end -}}
{{- end -}}

{{/* TODO: Unit tests*/}}
