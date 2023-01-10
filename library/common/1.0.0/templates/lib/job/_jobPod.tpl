{{/* This will be used when the (cron)job pod is deployed along with a "main" pod */}}
{{- define "ix.v1.common.job.pod" -}}
{{- $root := .root -}}
{{- $values := .values -}}
{{- $inherit := "inherit" -}}

{{/* Prepare values */}}
{{- $saName := "" -}}
{{- with $values.serviceAccountName -}}
  {{- if eq . $inherit -}}
    {{- $saName = (include "ix.v1.common.names.serviceAccountName" $root) -}}
  {{- else -}}
    {{- $saName = . -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $schedulerName := "" -}}
{{- with $values.schedulerName -}}
  {{- if eq . $inherit -}}
    {{- $schedulerName = (tpl $root.Values.schedulerName $root) -}}
  {{- else  -}}
    {{- $schedulerName = . -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $priorityClassName := "" -}}
{{- with $values.priorityClassName -}}
  {{- if eq . $inherit -}}
    {{- $priorityClassName = (tpl $root.Values.priorityClassName $root) -}}
  {{- else -}}
    {{- $priorityClassName = . -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $hostname := "" -}}
{{- with $values.hostname -}}
  {{- if eq . $inherit -}}
    {{- $hotsname = (tpl $root.Values.hostname $root) -}}
  {{- else  -}}
    {{- $hotsname = . -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $dnsPolicy := "" -}}
{{- with $values.dnsPolicy -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.dnsPolicy" (dict "dnsPolicy" $root.Values.dnsPolicy "hostNetwork" $root.Values.hostNetwork) | trim ) -}}
      {{- $dnsPolicy = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.dnsPolicy" (dict "dnsPolicy" $values.dnsPolicy "hostNetwork" ($values.hostNetwork | default $root.Values.hostNetwork)) | trim ) -}}
      {{- $dnsPolicy = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $dnsConfig := dict -}}
{{- with $values.dnsConfig -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.dnsConfig" (dict "dnsPolicy" $root.Values.dnsPolicy "dnsConfig" $root.Values.dnsConfig "root" $root) | trim ) -}}
      {{- $dnsConfig = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.dnsConfig" (dict "dnsPolicy" ($dnsPolicy | default $root.Values.dnsPolicy) "dnsConfig" $values.dnsConfig "root" $root) | trim ) -}}
      {{- $dnsConfig = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $hostAliases := dict -}}
{{- with $values.hostAliases -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.hostAliases" (dict "hostAliases" $root.Values.hostAliases "root" $root) | trim) -}}
      {{- $hostAliases = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.hostAliases" (dict "hostAliases" $values.hostAliases "root" $root) | trim) -}}
      {{- $hostAliases = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $nodeSelector := "" -}}
{{- with $values.nodeSelector -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.nodeSelector" (dict "nodeSelector" $root.Values.nodeSelector "root" $root) | trim) -}}
      {{- $nodeSelector = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.nodeSelector" (dict "nodeSelector" $values.nodeSelector "root" $root) | trim) -}}
      {{- $nodeSelector = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $tolerations := dict -}}
{{- with $values.tolerations -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.tolerations" (dict "tolerations" $root.Values.tolerations "root" $root) | trim) -}}
      {{- $tolerations = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.tolerations" (dict "tolerations" $values.tolerations "root" $root) | trim) -}}
      {{- $tolerations = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $imagePullSecrets := dict -}}
{{- with $values.imagePullSecrets -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.imagePullSecrets" (dict "imagePullCredentials" $root.Values.imagePullCredentials "root" $root) | trim) -}}
      {{- $imagePullSecrets = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.imagePullSecrets" (dict "imagePullCredentials" $values.imagePullCredentials "root" $root) | trim) -}}
      {{- $imagePullSecrets = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $runtimeClassName := "" -}}
{{- with $values.runtimeClassName -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.runtimeClassName" (dict "root" $root "runtime" $root.Values.runtimeClassName) | trim) -}}
      {{- $runtimeClassName = . -}}
    {{- end -}}
  {{- else -}}
    {{- with (include "ix.v1.common.runtimeClassName" (dict "root" $root "runtime" $root.Values.runtimeClassName) | trim) -}}
      {{- $runtimeClassName = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $termSeconds := "" }}
{{- with $values.termination -}}
  {{- if eq . $inherit -}}
    {{- with $root.Values.termination.gracePeriodSeconds }}
      {{- $termSeconds = . }}
    {{- end -}}
  {{- else -}}
    {{- with $values.termination.gracePeriodSeconds }}
      {{- $termSeconds = . }}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{/* If we ever have value in global.defaults */}}
{{- end -}}

{{- $secCont := dict -}}
{{- with $values.securityContext -}}
  {{- if eq . $inherit -}}
    {{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" $root.Values.podSecurityContext "root" $root) | trim) -}}
      {{- $secCont = . -}}
    {{- end -}}
  {{- end -}}
{{- else -}}
  {{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" $values.podSecurityContext "root" $root) | trim) -}}
    {{- $secCont = . -}}
  {{- end -}}
{{- end -}}

{{/* Now render the actual values */}}
{{- if hasKey $values "hostNetwork" -}}
  {{- if eq $values.hostNetwork $inherit }}
hostNetwork: {{ $root.Values.hostNetwork }}
  {{- else if (kindIs "bool" $values.hostNetwork) }}
hostNetwork: {{ $values.hostNetwork }}
  {{- end -}}
{{- else }}
hostNetwork: false
{{- end -}}

{{- if hasKey $values "enableServiceLinks" -}}
  {{- if eq $values.enableServiceLinks $inherit }}
enableServiceLinks: {{ $root.Values.enableServiceLinks }}
  {{- else if (kindIs "bool" $values.enableServiceLinks) }}
enableServiceLinks: {{ $values.enableServiceLinks }}
  {{- end -}}
{{- else }}
enableServiceLinks: false
{{- end -}}

{{- with $saName }}
serviceAccountName: {{ . }}
{{- end -}}

{{- with (include "ix.v1.common.restartPolicy" (dict "restartPolicy" $values.restartPolicy "isJob" true "root" $root) | trim) }}
restartPolicy: {{ . }}
{{- end -}}

{{- with $schedulerName }}
schedulerName: {{ . }}
{{- end -}}

{{- with $priorityClassName }}
priorityClassName: {{ . }}
{{- end -}}

{{- with $hostname }}
hostname: {{ . }}
{{- end -}}

{{- with $dnsPolicy }}
dnsPolicy: {{ . }}
{{- end -}}

{{- with $dnsConfig }}
dnsConfig:
  {{- . | nindent 2 }}
{{- end -}}

{{- with $hostAliases }}
hostAliases:
  {{- . | nindent 2 }}
{{- end -}}

{{- with $nodeSelector }}
nodeSelector:
  {{- . | nindent 2 }}
{{- end -}}

{{- with $tolerations }}
tolerations:
  {{- . | nindent 2 }}
{{- end -}}

{{- with $imagePullSecrets }}
imagePullSecrets:
  {{- . | nindent 2 }}
{{- end -}}

{{- with $runtimeClassName }}
runtimeClassname: {{ . }}
{{- end -}}

{{- with $termSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
securityContext:
  {{- $secCont | nindent 2 }}

{{- with (include "ix.v1.common.controller.extraContainers" (dict "root" $root "containerList" $values.containers "type" "job") | trim) }}
containers:
  {{- . | nindent 2 }}
{{- end -}}

{{- with (include "ix.v1.common.controller.volumes" (dict "persistence" $root.Values.persistence "root" $root) | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end -}}
{{- end -}}
