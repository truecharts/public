{{/* Pod Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.pod" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.workload.pod" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
serviceAccountName: {{ include "tc.v1.common.lib.pod.serviceAccountName" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
automountServiceAccountToken: {{ include "tc.v1.common.lib.pod.automountServiceAccountToken" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
runtimeClassName: {{ include "tc.v1.common.lib.pod.runtimeClassName" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
  {{- with (include "tc.v1.common.lib.pod.imagePullSecret" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
imagePullSecrets:
    {{-  . | nindent 2 }}
  {{- end }}
hostNetwork: {{ include "tc.v1.common.lib.pod.hostNetwork" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
hostPID: {{ include "tc.v1.common.lib.pod.hostPID" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
hostIPC: {{ include "tc.v1.common.lib.pod.hostIPC" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
shareProcessNamespace: {{ include "tc.v1.common.lib.pod.shareProcessNamespace" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
enableServiceLinks: {{ include "tc.v1.common.lib.pod.enableServiceLinks" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
restartPolicy: {{ include "tc.v1.common.lib.pod.restartPolicy" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
  {{- with (include "tc.v1.common.lib.pod.schedulerName" (dict "rootCtx" $rootCtx "objectData" $objectData)) }}
schedulerName: {{ . }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.priorityClassName" (dict "rootCtx" $rootCtx "objectData" $objectData)) }}
priorityClassName: {{ . }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.nodeSelector" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
nodeSelector:
    {{- . | nindent 2 }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.affinity" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
affinity:
    {{- . | nindent 2 }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.topologySpreadConstraints" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
topologySpreadConstraints:
    {{- . | nindent 2 }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.hostAliases" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
hostAliases:
    {{- . | nindent 2 }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.hostname" (dict "rootCtx" $rootCtx "objectData" $objectData)) }}
hostname: {{ . }}
  {{- end -}}
  {{- include "tc.v1.common.lib.pod.dns" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
  {{- with (include "tc.v1.common.lib.pod.terminationGracePeriodSeconds" (dict "rootCtx" $rootCtx "objectData" $objectData)) }}
terminationGracePeriodSeconds: {{ . }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.tolerations" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
tolerations:
    {{- . | nindent 2 }}
  {{- end }}
securityContext:
  {{- include "tc.v1.common.lib.pod.securityContext" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
hostUsers: {{ include "tc.v1.common.lib.pod.hostUsers" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
  {{- if $objectData.podSpec.containers }}
containers:
    {{- include "tc.v1.common.lib.pod.containerSpawner" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- end -}}
  {{- if $objectData.podSpec.initContainers }}
initContainers:
    {{- include "tc.v1.common.lib.pod.initContainerSpawner" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.pod.volumes" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
volumes:
  {{- . | nindent 2 }}
{{- end -}}
{{- end -}}
