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
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "common.all" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "common.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{- include "common.pvc" . }}
  {{- print "---" | nindent 0 -}}
  {{- if .Values.serviceAccount.create -}}
    {{- include "common.serviceAccount" . }}
    {{- print "---" | nindent 0 -}}
  {{- end -}}
  {{- if eq .Values.controllerType "deployment" }}
    {{- include "common.deployment" . | nindent 0 }}
  {{ else if eq .Values.controllerType "daemonset" }}
    {{- include "common.daemonset" . | nindent 0 }}
  {{ else if eq .Values.controllerType "statefulset"  }}
    {{- include "common.statefulset" . | nindent 0 }}
  {{- end -}}
  {{- print "---" | nindent 0 -}}
  {{ include "common.service" . | nindent 0 }}
  {{ include "common.appService" . | nindent 0 }}
  {{- print "---" | nindent 0 -}}
  {{ include "common.ingress" .  | nindent 0 }}
  {{- print "---" | nindent 0 -}}
  {{ include "common.appIngress" .  | nindent 0 }}
  {{ include "common.storage.permissions" .  | nindent 0 }}
{{- end -}}
