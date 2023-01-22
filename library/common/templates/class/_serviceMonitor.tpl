{{- define "ix.v1.common.class.servicemonitor" -}}
  {{- $fullName := include "ix.v1.common.names.fullname" . -}}
  {{- $servicemonitorName := $fullName -}}
  {{- $values := .Values.servicemonitor -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.servicemonitor -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $servicemonitorLabels := $values.labels -}}
  {{- $servicemonitorAnnotations := $values.annotations -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $servicemonitorName = printf "%v-%v" $servicemonitorName $values.nameOverride -}}
  {{- end }}
---
apiVersion: {{ include "tc.v1.common.capabilities.servicemonitor.apiVersion" $ }}
kind: PodMonitor
metadata:
  name: {{ $servicemonitorName }}
  {{- $labels := (mustMerge ($servicemonitorLabels | default dict) (include "ix.v1.common.labels" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($servicemonitorAnnotations | default dict) (include "ix.v1.common.annotations" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end -}}
spec:
  jobLabel: app.kubernetes.io/name
  selector:
    {{- if $values.matchLabels }}
      {{- tpl (toYaml $values.matchLabels) $ | nindent 4 }}
    {{- else -}}
      {{- include "ix.v1.common.labels.selectorLabels" . | nindent 4 -}}
    {{- end -}}
  endpoints:
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
