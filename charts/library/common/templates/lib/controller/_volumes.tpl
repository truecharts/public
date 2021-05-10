{{/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

`SPDX-License-Identifier: Apache-2.0`

This file is considered to be modified by the TrueCharts Project.
*/}}


{{/*
Volumes included by the controller.
*/}}
{{- define "common.controller.volumes" -}}
{{- range $index, $persistence := .Values.persistence }}
{{- if $persistence.enabled }}
- name: {{ $index }}
{{- if $persistence.existingClaim }}
{{- /* Always prefer an existingClaim if that is set */}}
  persistentVolumeClaim:
    claimName: {{ $persistence.existingClaim }}
{{- else -}}
  {{- /* Always prefer an emptyDir next if that is set */}}
  {{- $emptyDir := false -}}
  {{- if $persistence.emptyDir -}}
    {{- if $persistence.emptyDir.enabled -}}
      {{- $emptyDir = true -}}
    {{- end -}}
  {{- end -}}
  {{- if $emptyDir }}
  {{- if or $persistence.emptyDir.medium $persistence.emptyDir.sizeLimit }}
  emptyDir:
    {{- with $persistence.emptyDir.medium }}
    medium: "{{ . }}"
    {{- end }}
    {{- with $persistence.emptyDir.sizeLimit }}
    sizeLimit: "{{ . }}"
    {{- end }}
  {{- else }}
  emptyDir: {}
  {{- end }}
  {{- else -}}
  {{- /* Otherwise refer to the PVC name */}}
  {{- $pvcName := (include "common.names.fullname" $) -}}
  {{- if $persistence.nameOverride -}}
    {{- $pvcName = $persistence.nameOverride -}}
  {{- else if $persistence.nameSuffix -}}
    {{- if not (eq $persistence.nameSuffix "-") -}}
      {{- $pvcName = (printf "%s-%s" (include "common.names.fullname" $) $persistence.nameSuffix) -}}
    {{- end -}}
  {{- else -}}
    {{- $pvcName = (printf "%s-%s" (include "common.names.fullname" $) $index) -}}
  {{- end }}
  persistentVolumeClaim:
    claimName: {{ $pvcName }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- if .Values.additionalVolumes }}
  {{- toYaml .Values.additionalVolumes | nindent 0 }}
{{- end }}

{{- range $name, $dm := .Values.deviceMounts -}}
{{ if $dm.enabled }}
{{ if $dm.name }}
{{ $name = $dm.name }}
{{ end }}
- name: devicemount-{{ $name }}
  {{ if $dm.emptyDir }}
  emptyDir: {}
  {{- else -}}
  hostPath:
    path: {{ required "hostPath not set" $dm.devicePath }}
  {{ end }}
{{ end }}
{{- end -}}

{{/*
Creates Volumes for hostPaths which can be directly mounted to a container
*/}}
{{- range $name, $hpm := .Values.hostPathMounts -}}
{{ if $hpm.enabled }}
{{ if $hpm.name }}
{{ $name = $hpm.name }}
{{ end }}
- name: hostpathmounts-{{ $name }}
  {{ if $hpm.emptyDir }}
  emptyDir: {}
  {{- else -}}
  hostPath:
    path: {{ required "hostPath not set" $hpm.hostPath }}
  {{ end }}
{{ end }}
{{- end -}}

{{- end -}}
