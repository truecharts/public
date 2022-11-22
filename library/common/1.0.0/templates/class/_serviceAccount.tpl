{{/* Template for a ServiceAccount object, can only be called by the spawner */}}
{{/* A serviceAccount object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.serviceAccount" -}}
  {{- $values := .serviceAccount -}}
  {{- $root := .root -}}

  {{- $saName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $saName = (printf "%v-%v" $saName $values.nameOverride) -}}
  {{- end }}

---
apiVersion: {{ include "ix.v1.common.capabilities.serviceAccount.apiVersion" $root }}
kind: ServiceAccount
metadata:
  name: {{ $saName }}
  {{- $labels := (mustMerge ($values.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($values.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end -}}
{{- end }}
