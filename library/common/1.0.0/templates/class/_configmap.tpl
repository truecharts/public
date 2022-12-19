{{- define "ix.v1.common.class.configmap" -}}
  {{- $configName := .configName -}}
  {{- $data := .data -}}
  {{- $type := .type -}}
  {{- $root := .root -}}

---
apiVersion: {{ include "ix.v1.common.capabilities.configMap.apiVersion" $root }}
kind: ConfigMap
metadata:
  name: {{ $configName }}
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
  {{- range $k, $v := $data }}
    {{- $k | nindent 2 }}: {{ $v }}
  {{- end -}}
{{- end -}}
