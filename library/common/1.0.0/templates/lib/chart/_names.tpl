{{/*
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
global.nameOverride applies to the current chart and all sub-charts
nameOverride applies only to the current chart
*/}}

{{/* Expand ther name of the chart */}}
{{- define "ix.v1.common.names.name" -}}
  {{- $globalNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{/* Set to global.nameOverride if set, else set to empty */}}
    {{- $globalNameOverride = (default $globalNameOverride .Values.global.nameOverride) -}}
  {{- end -}}
    {{/* Order of preference: global.nameOverride -> nameOverride -> Chart.Name */}}
  {{- default .Chart.Name (default .Values.nameOverride $globalNameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create a default fully qualified app name. */}}
{{- define "ix.v1.common.names.fullname" -}}
  {{- $name := include "ix.v1.common.names.name" . -}}
  {{- $globalFullNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullnameOverride) -}}
  {{- end -}}
  {{- if or .Values.fullnameOverride $globalFullNameOverride -}}
    {{- $name = default .Values.fullnameOverride $globalFullNameOverride -}}
  {{- else -}}
    {{- if contains $name .Release.Name -}}
      {{- $name = .Release.Name -}}
    {{- else -}}
      {{- $name = printf "%s-%s" .Release.Name $name -}}
    {{- end -}}
  {{- end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "ix.v1.common.names.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the "name" + "." + "namespace" fqdn */}}
{{- define "ix.v1.common.names.fqdn" -}}
  {{- printf "%s.%s" (include "ix.v1.common.names.fullname" .) .Release.Namespace | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the "fqdn" + "." + "svc.cluster.local" */}}
{{- define "ix.v1.common.names.fqdn.cluster" -}}
  {{- printf "%s.%s" (include "ix.v1.common.names.fqdn" .) "svc.cluster.local" -}}
{{- end -}}

{{/* Return the properly cased version of the controller type */}}
{{- define "ix.v1.common.names.controllerType" -}}
  {{- if eq (.Values.controller.type | lower) "deployment" -}}
    {{- print "Deployment" -}}
  {{- else if eq (.Values.controller.type | lower) "daemonset" -}}
    {{- print "DaemonSet" -}}
  {{- else if eq (.Values.controller.type | lower) "statefulset"  -}}
    {{- print "StatefulSet" -}}
  {{- else -}}
    {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.names.serviceAccountName" -}}
  {{- $serviceAccountName := "default" -}}
    {{- range $name, $serviceAccount := .Values.serviceAccount -}}
      {{- if $serviceAccount.enabled -}}
        {{- if hasKey $serviceAccount "primary" -}}
          {{- if $serviceAccount.primary -}}
            {{- if $serviceAccount.nameOverride -}}
              {{- $serviceAccountName = (printf "%v-%v" (include "ix.v1.common.names.fullname" $) $serviceAccount.nameOverride) -}}
            {{- else -}}
              {{- $serviceAccountName = (include "ix.v1.common.names.fullname" $) -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- $serviceAccountName -}}
{{- end -}}
