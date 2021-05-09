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


{{- /*
The main container included in the controller.
*/ -}}
{{- define "common.controller.mainContainer" -}}
- name: {{ include "common.names.fullname" . }}
  image: "{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command: {{ . }}
  {{- end }}
  {{- with .Values.args }}
  args: {{ . }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  env:
    - name: PUID
      value: {{ .Values.PUID | quote }}
    - name: PGID
      value: {{ .Values.PGID | quote }}
    - name: UMASK
      value: {{ .Values.UMASK | quote }}
  {{- if .Values.timezone }}
    - name: TZ
      value: {{ .Values.timezone | quote }}
  {{- end }}
  {{- if or .Values.env .Values.envTpl .Values.envValueFrom .Values.envVariable .Values.environmentVariables }}
  {{- range $envVariable := .Values.environmentVariables }}
  {{- if and $envVariable.name $envVariable.value }}
    - name: {{ $envVariable.name }}
      value: {{ $envVariable.value | quote }}
  {{- else }}
    {{- fail "Please specify name/value for environment variable" }}
  {{- end }}
  {{- end}}
  {{- range $key, $value := .Values.env }}
    - name: {{ $key }}
      value: {{ $value | quote }}
  {{- end }}
  {{- range $key, $value := .Values.envTpl }}
    - name: {{ $key }}
      value: {{ tpl $value $ | quote }}
  {{- end }}
  {{- range $key, $value := .Values.envValueFrom }}
    - name: {{ $key }}
      valueFrom:
        {{- $value | toYaml | nindent 8 }}
  {{- end }}
  {{- end }}
  {{- with .Values.envFrom }}
  envFrom:
    {{- toYaml . | nindent 12 }}
  {{- end }}
  {{- include "common.controller.ports" . | trim | nindent 2 }}

  {{- with (include "common.controller.volumeMounts" . | trim) }}
  volumeMounts:
    {{- . | nindent 2 }}
  {{- end }}


  {{- include "common.controller.probes" . | nindent 2 }}
  resources:
  {{- with .Values.resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if and .Values.gpuConfiguration }}
    limits:
      {{- toYaml .Values.gpuConfiguration | nindent 6 }}
  {{- end }}
{{- end -}}
