{{/* Job Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.jobSpec" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  backoffLimit: The number of retries before marking this job failed. Defaults to 6.
  completions: The desired number of successfully finished pods the job should be run with. Defaults to 1.
  parallelism: The maximum desired number of pods the job should run at any given time. Defaults to 1.
  activeDeadlineSeconds: Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer. If set to nil, the job is never terminated due to timeout.
  ttlSecondsAfterFinished: TTLSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes. This field is alpha-level and is only honored by servers that enable the TTLAfterFinished feature.
  completionMode: CompletionMode specifies how Pod completions are tracked. It can be `NonIndexed` (default) or `Indexed`.
*/}}
{{- define "tc.v1.common.lib.workload.jobSpec" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $parallelism := 1 -}}
  {{- if hasKey $objectData "parallelism" -}}
    {{- $parallelism = $objectData.parallelism -}}
  {{- end -}}
  {{- if (include "tc.v1.common.lib.util.stopAll" $rootCtx) -}}
    {{- $parallelism = 0 -}}
  {{- end }}
backoffLimit: {{ $objectData.backoffLimit | default 5 }}
completionMode: {{ $objectData.completionMode | default "NonIndexed" }}
completions: {{ $objectData.completions | default nil }}
parallelism: {{ $parallelism }}
ttlSecondsAfterFinished: {{ $objectData.ttlSecondsAfterFinished | default 120 }}
  {{- with $objectData.activeDeadlineSeconds }}
activeDeadlineSeconds: {{ . }}
  {{- end -}}
{{- end -}}
