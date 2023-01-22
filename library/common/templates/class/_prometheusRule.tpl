{{- define "ix.v1.common.class.prometheusrule" -}}
  {{- $fullName := include "ix.v1.common.names.fullname" . -}}
  {{- $prometheusruleName := $fullName -}}
  {{- $values := .Values.prometheusrule -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.prometheusrule -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $prometheusruleLabels := $values.labels -}}
  {{- $prometheusruleAnnotations := $values.annotations -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $prometheusruleName = printf "%v-%v" $prometheusruleName $values.nameOverride -}}
  {{- end }}
---
apiVersion: {{ include "tc.v1.common.capabilities.prometheusrule.apiVersion" $ }}
kind: PrometheusRule
metadata:
  name: {{ $prometheusruleName }}
  {{- $labels := (mustMerge ($prometheusruleLabels | default dict) (include "ix.v1.common.labels" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($prometheusruleAnnotations | default dict) (include "ix.v1.common.annotations" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end -}}
spec:
  groups:
    {{- range $name, $groupValues := .groups }}
    - name: {{ $prometheusruleName }}-{{ $name }}
      rules:
        {{- with $groupValues.rules }}
          {{- toYaml . | nindent 8 }}
        {{- end -}}
        {{- with $groupValues.additionalrules }}
          {{- toYaml . | nindent 8 }}
        {{- end -}}
    {{- end -}}
    {{- range $id, $groupValues := .additionalgroups }}
    - name: {{ $prometheusruleName }}-{{ if $groupValues.name }}{{ $groupValues.name }}{{ else }}{{ $id }}{{ end }}
      rules:
        {{- with $groupValues.rules }}
          {{- toYaml . | nindent 8 }}
        {{- end -}}
        {{- with $groupValues.additionalrules }}
          {{- toYaml . | nindent 8 }}
        {{- end -}}
    {{- end -}}
{{- end -}}
