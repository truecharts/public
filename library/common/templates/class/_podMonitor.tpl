{{- define "tc.v1.common.class.podmonitor" -}}
  {{- $fullName := include "ix.v1.common.names.fullname" . -}}
  {{- $podmonitorName := $fullName -}}
  {{- $values := .Values.podmonitor -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.metrics -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $podmonitorLabels := $values.labels -}}
  {{- $podmonitorAnnotations := $values.annotations -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $podmonitorName = printf "%v-%v" $podmonitorName $values.nameOverride -}}
  {{- end }}
---
apiVersion: {{ include "tc.v1.common.capabilities.podmonitor.apiVersion" $ }}
kind: PodMonitor
metadata:
  name: {{ $podmonitorName }}
  {{- $labels := (mustMerge ($podmonitorLabels | default dict) (include "ix.v1.common.labels" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($podmonitorAnnotations | default dict) (include "ix.v1.common.annotations" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  jobLabel: app.kubernetes.io/name
  selector:
    {{- if $values.selector }}
    {{- tpl (toYaml $values.selector) $ | nindent 4 }}
    {{- else }}
    matchLabels:
      {{- include "ix.v1.common.labels.selectorLabels" $ | nindent 6 }}
    {{- end }}
  podMetricsEndpoints:
    {{- tpl (toYaml $values.endpoints) $ | nindent 4 }}
{{- end -}}
