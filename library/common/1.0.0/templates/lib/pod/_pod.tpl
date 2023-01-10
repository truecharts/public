{{/* The pod definition included in the controller. */}}
{{- define "ix.v1.common.controller.pod" -}}
{{- $root := . }}
serviceAccountName: {{ (include "ix.v1.common.names.serviceAccountName" $root) }}
hostNetwork: {{ $root.Values.hostNetwork }}
enableServiceLinks: {{ $root.Values.enableServiceLinks }}
{{- with (include "ix.v1.common.restartPolicy" (dict "restartPolicy" $root.Values.restartPolicy "root" $root) | trim) }}
restartPolicy: {{ . }}
{{- end -}}

{{- with (tpl $root.Values.schedulerName $root) }}
schedulerName: {{ . }}
{{- end -}}

{{- with (tpl $root.Values.priorityClassName $root) }}
priorityClassName: {{ . }}
{{- end }}

{{- with (tpl $root.Values.hostname $root) }}
hostname: {{ . }}
{{- end -}}

{{- with (include "ix.v1.common.dnsPolicy" (dict "dnsPolicy" $root.Values.dnsPolicy "hostNetwork" $root.Values.hostNetwork) | trim ) }}
dnsPolicy: {{ . }}
{{- end -}}

{{- with (include "ix.v1.common.dnsConfig" (dict "dnsPolicy" $root.Values.dnsPolicy "dnsConfig" $root.Values.dnsConfig "root" $root) | trim ) }}
dnsConfig:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.hostAliases" (dict "hostAliases" $root.Values.hostAliases "root" $root) | trim) }}
hostAliases:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.nodeSelector" (dict "nodeSelector" $root.Values.nodeSelector "root" $root) | trim) }}
nodeSelector:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.tolerations" (dict "tolerations" $root.Values.tolerations "root" $root) | trim) }}
tolerations:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.imagePullSecrets" (dict "imagePullCredentials" $root.Values.imagePullCredentials "root" $root) | trim) }}
imagePullSecrets:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.runtimeClassName" (dict "root" $root "runtime" $root.Values.runtimeClassName) | trim) }}
runtimeClassName: {{ . }}
{{- end -}}

{{/* TODO: affinity, topologySpreadConstraints, not something critical as of now. */}}
{{- with $root.Values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end -}}

{{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" $root.Values.podSecurityContext "root" $root) | trim) }}
securityContext:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.controller.mainContainer" (dict "values" $root.Values "root" $root) | trim) }}
containers:
  {{- . | nindent 2 }}
  {{- (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $root.Values.additionalContainers "type" "addititional") | trim) | nindent 2 }}
{{- end -}}

{{- if or $root.Values.initContainers $root.Values.installContainers $root.Values.upgradeContainers }}
initContainers:
  {{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $root.Values.installContainers "type" "install") | trim) -}}
    {{- . | nindent 2 }}
  {{- end -}}

  {{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $root.Values.upgradeContainers "type" "upgrade") | trim) -}}
    {{- . | nindent 2 }}
  {{- end -}}

  {{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $root.Values.initContainers "type" "init") | trim) -}}
    {{- . | nindent 2 }}
  {{- end -}}
{{- end -}}

{{- with (include "ix.v1.common.controller.volumes" (dict "persistence" $root.Values.persistence "root" $root) | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end -}}

{{- end -}}
