{{- define "ix.v1.common.class.job" -}}
  {{- $job := .job -}}
  {{- $root := .root -}}
  {{- $jobName := include "ix.v1.common.names.jobAndCronJob" (dict "root" $root "jobValues" $job) }}

---
apiVersion: {{ include "ix.v1.common.capabilities.job.apiVersion" . }}
kind: Job
metadata:
  name: {{ $jobName }}
  {{- $labels := (mustMerge ($job.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($job.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  {{- include "ix.v1.common.lib.job" (dict "root" $root "job" $job) | indent 2 -}}
{{- end -}}
