{{/* The pod definition included in the controller. */}}
{{- define "ix.v1.common.controller.pod" -}}
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
{{- with .Values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
enableServiceLinks: {{ .Values.enableServiceLinks }}
{{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" .Values.podSecurityContext) | trim) }}
securityContext:
  {{- . | nindent 2 }}
{{- end }}
containers:
  {{- include "ix.v1.common.controller.mainContainer" . | nindent 2 }}
{{- with (include "ix.v1.common.controller.volumes" . | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end }}
{{- end -}}
