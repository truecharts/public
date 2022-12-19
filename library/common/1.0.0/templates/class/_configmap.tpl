{{- define "ix.v1.common.class.configmap" -}}
  {{- $configName := .configName -}}
  {{- $data := .data -}}
  {{- $type := .type -}}
  {{- $configLabels := .labels -}}
  {{- $configAnnotations := .annotations -}}
  {{- $root := .root -}}

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
  {{- if eq $type "key_value" -}}
    {{- range $k, $v := $data }}
      {{- $k | nindent 2 }}: {{ $v }}
    {{- end -}}
  {{- else if eq $type "scalar" }}
    {{- $data | nindent 2 }}
  {{- else -}}
    {{- fail (printf "Invalid type (%s) for configmap. Valid types are scalar and key_value" $type) -}}
  {{- end -}}
{{- end -}}

{{/* TODO: Unit tests*/}}
