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
  {{- if $persistence.emptyDir -}}
  {{- /* Always prefer an emptyDir next if that is set */}}
  emptyDir: {}
  {{- else -}}
  {{- /* Otherwise refer to the PVC name */}}
  persistentVolumeClaim:
    {{- if $persistence.nameOverride }}
    claimName: {{ $persistence.nameOverride }}
    {{- else if $persistence.nameSuffix }}
    claimName: {{ printf "%s-%s" (include "common.names.fullname" $) $persistence.nameSuffix }}
    {{- else }}
    claimName: {{ printf "%s-%s" (include "common.names.fullname" $) $index }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
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

{{- range $name, $cs := .Values.customStorage -}}
{{ if $cs.enabled }}
{{ if $cs.name }}
{{ $name = $cs.name }}
{{ end }}
- name: customstorage-{{ $name }}
  {{ if $cs.emptyDir }}
  emptyDir: {}
  {{- else -}}
  hostPath:
    path: {{ required "hostPath not set" $cs.hostPath }}
  {{ end }}
{{ end }}
{{- end -}}


{{- if .Values.additionalVolumes }}
  {{- toYaml .Values.additionalVolumes | nindent 0 }}
{{- end }}
{{- end -}}
