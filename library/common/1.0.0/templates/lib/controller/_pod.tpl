{{/* The pod definition included in the controller. */}}
{{- define "ix.v1.common.controller.pod" -}}
{{/* TODO: serviceAccountName */}}
{{- with .Values.schedulerName }}
schedulerName: {{ tpl . $ }}
{{- end }}
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
{{/* TODO: imagePullSecrets, affinity, topologySpreadConstraints, not something critical as of now. */}}
{{- with .Values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
enableServiceLinks: {{ .Values.enableServiceLinks }}
{{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" .Values.podSecurityContext) | trim) }}
securityContext:
  {{- . | nindent 2 }}
{{- end }}
{{- with (include "ix.v1.common.controller.mainContainer" . | trim) }}
containers:
  {{- . | nindent 2 }}
{{- end }}
{{- with (include "ix.v1.common.controller.volumes" . | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end -}}
{{- end -}}
