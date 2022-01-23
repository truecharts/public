{{- /*
The pod definition included in the controller.
*/ -}}
{{- define "common.controller.pod" -}}
  {{- with .Values.imagePullSecrets }}
imagePullSecrets:
    {{- toYaml . | nindent 2 }}
  {{- end }}
serviceAccountName: {{ include "common.names.serviceAccountName" . }}
  {{- with .Values.podSecurityContext }}
securityContext:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.priorityClassName }}
priorityClassName: {{ . }}
  {{- end }}
  {{- with .Values.schedulerName }}
schedulerName: {{ . }}
  {{- end }}
  {{- with .Values.hostNetwork }}
hostNetwork: {{ . }}
  {{- end }}
  {{- with .Values.hostname }}
hostname: {{ . }}
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
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.dnsConfig.nameservers }}
  nameservers: []
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.dnsConfig.searches }}
  searches: []
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
enableServiceLinks: {{ .Values.enableServiceLinks }}
  {{- with .Values.termination.gracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
  {{- end }}
initContainers:
  {{-  include "common.controller.autopermissions" . | nindent 2 }}
  {{-  include "common.dependencies.postgresql.init" . | nindent 2 }}
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
  {{- if .Release.IsInstall }}
  {{- if .Values.installContainers }}
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
  {{- end }}
  {{- if .Release.IsUpgrade }}
  {{- if .Values.upgradeContainers }}
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
  {{- end }}
containers:
  {{- include "common.controller.mainContainer" . | nindent 2 }}
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
  {{- with (include "common.controller.volumes" . | trim) }}
volumes:
    {{- nindent 2 . }}
  {{- end }}
  {{- with .Values.hostAliases }}
hostAliases:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.nodeSelector }}
nodeSelector:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.affinity }}
affinity:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.topologySpreadConstraints }}
topologySpreadConstraints:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.tolerations }}
tolerations:
    {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end -}}
