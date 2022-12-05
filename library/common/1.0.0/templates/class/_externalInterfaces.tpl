{{- define "ix.v1.common.class.externalInterface" -}}
  {{- $iface := .iface -}}
  {{- $index := .index -}}
  {{- $root := .root }}
---
apiVersion: {{ include "ix.v1.common.capabilities.externalInterfaces.apiVersion" . }}
kind: NetworkAttachmentDefinition
metadata:
  name: ix-{{ $root.Release.Name }}-{{ $index }}
  {{- $labels := (include "ix.v1.common.labels" $root | fromYaml) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (include "ix.v1.common.annotations" $root | fromYaml) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  config: {{ $iface | squote }}
{{- end -}}
