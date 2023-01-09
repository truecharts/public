{{/* The pod definition included in the controller. */}}
{{- define "ix.v1.common.controller.pod" -}}
{{- $root := .root }}
{{- $values := .values -}}
serviceAccountName: {{ (include "ix.v1.common.names.serviceAccountName" $root) }}
{{- with $values.schedulerName }}
schedulerName: {{ tpl . $root }}
{{- end }}
{{- with (include "ix.v1.common.restartPolicy" $root | trim ) }}
restartPolicy:
  {{- . | nindent 2 }}
{{- end -}}
{{- with $values.priorityClassName }}
priorityClassName: {{ tpl . $root }}
{{- end }}
hostNetwork: {{ $values.hostNetwork }}
{{- with $values.hostname }}
hostname: {{ tpl . $root }}
{{- end -}}
{{- with (include "ix.v1.common.dnsPolicy" (dict "dnsPolicy" $values.dnsPolicy "hostNetwork" $values.hostNetwork) | trim ) }}
dnsPolicy: {{ . }}
{{- end -}}
{{- with (include "ix.v1.common.dnsConfig" (dict "dnsPolicy" $values.dnsPolicy "dnsConfig" $values.dnsConfig "root" $root) | trim ) }}
dnsConfig:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.hostAliases" (dict "hostAliases" $values.hostAliases "root" $root) | trim) }}
hostAliases:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.nodeSelector" (dict "nodeSelector" $values.nodeSelector "root" $root) | trim) }}
nodeSelector:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.tolerations" (dict "tolerations" $values.tolerations "root" $root) | trim) }}
tolerations:
  {{- . | nindent 2 }}
{{- end -}}
{{/* TODO: affinity, topologySpreadConstraints, not something critical as of now. */}}
{{- with $values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
enableServiceLinks: {{ $values.enableServiceLinks }}
{{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" $values.podSecurityContext "root" $root) | trim) }}
securityContext:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.imagePullSecrets" (dict "imagePullCredentials" $values.imagePullCredentials "root" $root) | trim) }}
imagePullSecrets:
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.runtimeClassName" (dict "root" $root "runtime" $values.runtimeClassName) | trim) }}
runtimeClassName: {{ . }}
{{- end -}}
{{- with (include "ix.v1.common.controller.mainContainer" (dict "values" $values "root" $root) | trim) }}
containers:
  {{- . | nindent 2 }}
  {{- (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $values.additionalContainers "type" "addititional") | trim) | nindent 2 }}
{{- end -}}
{{- if or $values.initContainers $values.installContainers $values.upgradeContainers }}
initContainers:
{{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $values.installContainers "type" "install") | trim) -}}
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $values.upgradeContainers "type" "upgrade") | trim) -}}
  {{- . | nindent 2 }}
{{- end -}}
{{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $values.initContainers "type" "init") | trim) -}}
  {{- . | nindent 2 }}
{{- end -}}
{{- end -}}
{{- with (include "ix.v1.common.controller.volumes" (dict "persistence" $values.persistence "root" $root) | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end -}}
{{- end -}}
