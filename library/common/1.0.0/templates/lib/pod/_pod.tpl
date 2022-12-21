{{/* The pod definition included in the controller. */}}
{{- define "ix.v1.common.controller.pod" -}}
serviceAccountName: {{ (include "ix.v1.common.names.serviceAccountName" .) }}
{{- with .Values.schedulerName }}
schedulerName: {{ tpl . $ }}
{{- end }}
{{- with (include "ix.v1.common.restartPolicy" . | trim ) }}
restartPolicy:
  {{- . | nindent 2 }}
{{- end -}}
{{- with .Values.priorityClassName }}
priorityClassName: {{ tpl . $ }}
{{- end }}
hostNetwork: {{ .Values.hostNetwork }}
{{- with .Values.hostname }}
hostname: {{ tpl . $ }}
{{- end -}}
{{- with (include "ix.v1.common.dnsPolicy" . | trim ) }}
dnsPolicy: {{ . }}
{{- end -}}
{{- with (include "ix.v1.common.dnsConfig" . | trim ) }}
dnsConfig:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.hostAliases" . | trim) }}
hostAliases:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.nodeSelector" . | trim) }}
nodeSelector:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.tolerations" . | trim) }}
tolerations:
  {{- . | nindent 2 }}
{{- end -}}
{{/* TODO: affinity, topologySpreadConstraints, not something critical as of now. */}}
{{- with .Values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
enableServiceLinks: {{ .Values.enableServiceLinks }}
{{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" .Values.podSecurityContext) | trim) }}
securityContext:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.imagePullSecrets" . | trim) }}
imagePullSecrets:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.runtimeClassName" (dict "root" . "runtimeClassName" .Values.runtimeClassName) | trim) }}
runtimeClassName: {{ . }}
{{- end -}}
{{- with (include "ix.v1.common.controller.mainContainer" . | trim) }}
containers:
  {{- . | nindent 2 }}
{{- end -}}{{/*TODO: init/install/upgradeContainers */}}
{{- with (include "ix.v1.common.controller.initContainers" (dict "root" . "initContainers" .Values.initContainers) | trim) }}
initContainers:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.controller.volumes" . | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end -}}
{{- end -}}
