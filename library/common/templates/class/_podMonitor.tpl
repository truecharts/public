{{- define "ix.v1.common.class.podmonitor" -}}
  {{- $fullName := include "ix.v1.common.names.fullname" . -}}
  {{- $podmonitorName := $fullName -}}
  {{- $values := .Values.podmonitor -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.podmonitor -}}
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
  {{- end -}}
  {{- $annotations := (mustMerge ($podmonitorAnnotations | default dict) (include "ix.v1.common.annotations" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end -}}
spec:
  jobLabel: app.kubernetes.io/name
  selector:
    {{- if $values.matchLabels }}
      {{- tpl (toYaml $values.matchLabels) $ | nindent 4 }}
    {{- else }}
      {{- include "ix.v1.common.labels.selectorLabels" . | nindent 4 }}
    {{- end }}
  podMetricsEndpoints:
    {{- range $values.endpoints }}
    - port: {{ .port }}
      {{- with .interval }}
      interval: {{ . }}
      {{- end -}}
      {{- with .scrapeTimeout }}
      scrapeTimeout: {{ . }}
      {{- end -}}
      {{- with .path }}
      path: {{ . }}
      {{- end -}}
      {{- with .honorLabels }}
      honorLabels: {{ . }}
      {{- end -}}
    {{- end -}}
{{- end -}}
