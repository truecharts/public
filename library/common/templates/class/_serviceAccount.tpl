{{/* Template for a ServiceAccount object, can only be called by the spawner */}}
{{/* A serviceAccount object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.serviceAccount" -}}
  {{- $saValues := .serviceAccount -}}
  {{- $root := .root -}}
  {{- if hasKey $saValues "automountServiceAccountToken" -}}
    {{- if not (kindIs "bool" $saValues.automountServiceAccountToken) -}}
      {{- fail (printf "<automountServiceAccountToken> value (%s) must be boolean" $saValues.automountServiceAccountToken ) -}}
    {{- end -}}
  {{- else -}}
    {{- $_ := set $saValues "automountServiceAccountToken" true -}}
  {{- end -}}

  {{- $saName := include "ix.v1.common.names.serviceAccount" (dict "root" $root "saValues" $saValues) }}
---
apiVersion: {{ include "ix.v1.common.capabilities.serviceAccount.apiVersion" $root }}
kind: ServiceAccount
metadata:
  name: {{ $saName }}
  {{- $labels := (mustMerge ($saValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($saValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
automountServiceAccountToken: {{ $saValues.automountServiceAccountToken }}
{{- end }}
