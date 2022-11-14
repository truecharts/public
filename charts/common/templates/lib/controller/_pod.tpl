{{/*
The pod definition included in the controller.
*/}}
{{- define "tc.common.controller.pod" -}}
  {{- with .Values.imagePullSecrets }}
imagePullSecrets:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}

{{- $saName := include "tc.common.names.fullname" . -}}
{{- if not .Values.serviceAccount.main.enabled }}
  {{ $saName = "default" }}
{{- end }}
serviceAccountName: {{ $saName }}
  {{- with .Values.podSecurityContext }}
securityContext:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}
  {{- with .Values.priorityClassName }}
priorityClassName: {{ tpl . $ }}
  {{- end }}
  {{- with .Values.schedulerName }}
schedulerName: {{ tpl . $ }}
  {{- end }}
  {{- with .Values.hostNetwork }}
hostNetwork: {{ . }}
  {{- end }}
  {{- with .Values.hostname }}
hostname: {{ tpl . $ }}
  {{- end }}
  {{- if .Values.dnsPolicy }}
dnsPolicy: {{ .Values.dnsPolicy }}
  {{- else if .Values.hostNetwork }}
dnsPolicy: ClusterFirstWithHostNet
  {{- else }}
dnsPolicy: ClusterFirst
  {{- end }}
{{- if or .Values.dnsConfig.options .Values.dnsConfig.nameservers .Values.dnsConfig.searches }}
dnsConfig:
  {{- with .Values.dnsConfig.options }}
  options:
    {{ tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  {{- with .Values.dnsConfig.nameservers }}
  nameservers:
    {{ tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  {{- with .Values.dnsConfig.searches }}
  searches:
    {{ tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
{{- end }}
enableServiceLinks: {{ .Values.enableServiceLinks }}
  {{- with .Values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
  {{- end }}
initContainers:
  {{- include "tc.common.controller.prepare" . | nindent 2 }}
  {{- if and ( or ( .Release.IsInstall ) ( .Values.test.install ) ) ( .Values.installContainers )}}
    {{- $installContainers := list }}
    {{- range $index, $key := (keys .Values.installContainers | uniq | sortAlpha) }}
      {{- $container := get $.Values.installContainers $key }}
      {{- if not $container.name -}}
        {{- $_ := set $container "name" $key }}
      {{- end }}
      {{- $installContainers = append $installContainers $container }}
    {{- end }}
    {{- tpl (toYaml $installContainers) $ | nindent 2 }}
  {{- end }}
  {{- if and ( or ( .Release.IsUpgrade ) ( .Values.test.upgrade ) ) ( .Values.upgradeContainers )}}
    {{- $upgradeContainers := list }}
    {{- range $index, $key := (keys .Values.upgradeContainers | uniq | sortAlpha) }}
      {{- $container := get $.Values.upgradeContainers $key }}
      {{- if not $container.name -}}
        {{- $_ := set $container "name" $key }}
      {{- end }}
      {{- $upgradeContainers = append $upgradeContainers $container }}
    {{- end }}
    {{- tpl (toYaml $upgradeContainers) $ | nindent 2 }}
  {{- end }}
  {{- if .Values.initContainers }}
    {{- $initContainers := list }}
    {{- range $index, $key := (keys .Values.initContainers | uniq | sortAlpha) }}
      {{- $container := get $.Values.initContainers $key }}
      {{- if not $container.name -}}
        {{- $_ := set $container "name" $key }}
      {{- end }}
      {{- $initContainers = append $initContainers $container }}
    {{- end }}
    {{- tpl (toYaml $initContainers) $ | nindent 2 }}
  {{- end }}
containers:
  {{- include "tc.common.controller.mainContainer" . | nindent 2 }}
  {{- with .Values.additionalContainers }}
    {{- $additionalContainers := list }}
    {{- range $name, $container := . }}
      {{- if not $container.name -}}
        {{- $_ := set $container "name" $name }}
      {{- end }}
      {{- $additionalContainers = append $additionalContainers $container }}
    {{- end }}
    {{- tpl (toYaml $additionalContainers) $ | nindent 2 }}
  {{- end }}
  {{- with (include "tc.common.controller.volumes" . | trim) }}
volumes:
    {{- nindent 2 . }}
  {{- end }}
  {{- with .Values.hostAliases }}
hostAliases:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}
  {{- with .Values.nodeSelector }}
nodeSelector:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}
  {{- with .Values.affinity }}
affinity:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}
  {{- with .Values.topologySpreadConstraints }}
topologySpreadConstraints:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}
  {{- with .Values.tolerations }}
tolerations:
    {{ tpl ( toYaml . ) $ | nindent 2 }}
  {{- end }}
{{- end -}}
