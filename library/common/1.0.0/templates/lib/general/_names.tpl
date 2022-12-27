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
    {{- $globalNameOverride = (.Values.global.nameOverride | default $globalNameOverride) -}}
  {{- end -}}

  {{/* Order of preference: global.nameOverride -> nameOverride -> Chart.Name */}}
  {{- ($globalNameOverride | default .Values.nameOverride) | default .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create a default fully qualified app name. */}}
{{- define "ix.v1.common.names.fullname" -}}
  {{- $name := include "ix.v1.common.names.name" . -}}
  {{- $globalFullNameOverride := "" -}}

  {{- if hasKey .Values "global" -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullnameOverride) -}}
  {{- end -}}

  {{- if or .Values.fullnameOverride $globalFullNameOverride -}}
    {{- $name = $globalFullNameOverride | default .Values.fullnameOverride -}}
  {{- else -}}
    {{- if contains $name .Release.Name -}}
      {{- $name = .Release.Name -}}
    {{- else -}}
      {{- $name = printf "%s-%s" .Release.Name $name -}}
    {{- end -}}
  {{- end -}}

  {{- $name | trunc 63 | trimSuffix "-" -}}
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
  {{- if eq .Values.controller.type "deployment" -}}
    {{- print "Deployment" -}}
  {{- else if eq .Values.controller.type "daemonset" -}}
    {{- print "DaemonSet" -}}
  {{- else if eq .Values.controller.type "statefulset"  -}}
    {{- print "StatefulSet" -}}
  {{- else -}}
    {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) -}}
  {{- end -}}
{{- end -}}

{{/* Returns the serviceAccoutName. The name of the primary, if any, otherwise "default" */}}
{{- define "ix.v1.common.names.pod.serviceAccountName" -}}
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

{{/* Returns the service name */}}
{{- define "ix.v1.common.names.serviceAccount" -}}
  {{- $root := .root -}}
  {{- $saValues := .saValues -}}

  {{- if or (not $root) (not $saValues) -}}
    {{- fail "Named function <names.serviceAccount> did not receive required values" -}}
  {{- end -}}

  {{- $saName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $saValues "nameOverride") $saValues.nameOverride -}}
    {{- $saName = (printf "%v-%v" $saName $saValues.nameOverride) -}}
  {{- end -}}

  {{- $saName -}}
{{- end -}}

{{/* Returns the pvcName. */}}
{{- define "ix.v1.common.names.pvc" -}}
  {{- $root := .root -}}
  {{- $pvcValues := .pvcValues -}}

  {{- if or (not $root) (not $pvcValues) -}}
    {{- fail "Named function <names.pvcName> did not receive required values" -}}
  {{- end -}}

  {{- $pvcName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $pvcValues "nameOverride") $pvcValues.nameOverride -}}
    {{- if not (eq $pvcValues.nameOverride "-") -}}
      {{- $pvcName = printf "%v-%v" $pvcName $pvcValues.nameOverride -}}
    {{- end -}}
  {{- end -}}

  {{- with $pvcValues.forceName -}}
    {{- $pvcName = tpl . $root -}}
  {{- end -}}

  {{- $pvcName -}}
{{- end -}}

{{/* Returns the container name. */}}
{{- define "ix.v1.common.names.container" -}}
  {{- $root := .root -}}
  {{- $containerName := .containerName -}}

  {{- if or (not $root) (not $containerName) -}}
    {{- fail "Named function <names.container> did not receive required values" -}}
  {{- end -}}

  {{- if ne $containerName ($containerName | lower) -}}
    {{- fail (printf "Name (%s) of Init Container must be all lowercase" $containerName) -}}
  {{- end -}}
  {{- $name := (printf "%s-%s" (include "ix.v1.common.names.fullname" $root) $containerName) -}}

  {{- $name -}}
{{- end -}}

{{/* Returns secretName for imagePullSecrets */}}
{{- define "ix.v1.common.names.imagePullSecret" -}}
  {{- $root := .root -}}
  {{- $imgPullCredsName := .imgPullCredsName -}}

  {{- if or (not $root) (not $imgPullCredsName) -}}
    {{- fail "Named function <names.imagePullSecret> did not receive required values" -}}
  {{- end -}}

  {{- $secretName := printf "%v-%v" (include "ix.v1.common.names.fullname" $root) ($imgPullCredsName | lower) | trunc 63 -}}

  {{- $secretName -}}
{{- end -}}

{{/* Returns the name for configmap and secrets */}}
{{- define "ix.v1.common.names.configmapAndSecret" -}}
  {{- $root := .root -}}
  {{- $objName := .objName -}}
  {{- $objData := .objData -}}
  {{- $objType := .objType -}}

  {{- if or (not $root) (not $objName) (not $objData) (not $objType) -}}
    {{- fail "Named function <names.configmapAndSecret> did not receive required values" -}}
  {{- end -}}

  {{- if ne $objName ($objName | lower) -}}
    {{- fail (printf "%s has invalid name (%s). Name must be lowercase." (camelcase $objType) $objName) -}}
  {{- end -}}
  {{- if contains "_" $objName -}}
    {{- fail (printf "%s has invalid name (%s). Name cannot contain underscores (_)." (camelcase $objType) $objName) -}}
  {{- end -}}

  {{- $generatedName := include "ix.v1.common.names.fullname" $root -}}
  {{- if and (hasKey $objData "nameOverride") $objData.nameOverride -}}
    {{- $generatedName = printf "%v-%v" $generatedName $objData.nameOverride -}}
  {{- else -}}
    {{- $generatedName = printf "%v-%v" $generatedName $objName -}}
  {{- end -}}

  {{- $generatedName -}}
{{- end -}}

{{/* Returns the name for certificate secret */}}
{{- define "ix.v1.common.names.certificateSecret" -}}
  {{- $root := .root -}}
  {{- $certName := .certName -}}
  {{- $certValues := .certValues -}}
  {{- $certID := .certID -}}

  {{- if or (not $root) (not $certName) (not $certValues) (not $certID) -}}
    {{- fail "Named function <names.certificateSecret> did not receive required values" -}}
  {{- end -}}

  {{- if ne $certName ($certName | lower) -}}
    {{- fail (printf "Certificate has invalid name (%s). Name must be lowercase." $certName) -}}
  {{- end -}}
  {{- if contains "_" $certName -}}
    {{- fail (printf "Certificate has invalid name (%s). Name cannot contain underscores (_)" $certName) -}}
  {{- end -}}

  {{/* Default to $name if there is not a nameOverride given */}}
  {{- if not $certValues.nameOverride -}}
    {{- $_ := set $certValues "nameOverride" $certName -}}
  {{- end -}}

  {{- $secretName := include "ix.v1.common.names.fullname" $root -}}
  {{- if $certValues.nameOverride -}}
    {{- $secretName = (printf "%v-%v-%v-%v" $secretName $certValues.nameOverride "ixcert" $certID) -}}
  {{- else -}}
    {{- $secretName = (printf "%v-%v-%v" $secretName "ixcert" $certID) -}}
  {{- end -}}
  {{- $secretName = (printf "%v-%v" $secretName $root.Release.Revision) -}}

  {{- $secretName -}}
{{- end -}}

{{/* Returns the serviceName. */}}
{{- define "ix.v1.common.names.service" -}}
  {{- $root := .root -}}
  {{- $svcValues := .svcValues -}}

  {{- if or (not $root) (not $svcValues) -}}
    {{- fail "Named function <names.service> did not receive required values" -}}
  {{- end -}}

  {{- $svcName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $svcValues "nameOverride") $svcValues.nameOverride -}}
    {{- $svcName = (printf "%v-%v" $svcName $svcValues.nameOverride) -}}
  {{- end -}}

  {{- $svcName -}}
{{- end -}}
