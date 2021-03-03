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
Probes selection logic.
*/}}
{{- define "common.controller.probes" -}}
{{- $svcPort := .Values.services.main.port.name -}}
{{- range $probeName, $probe := .Values.probes }}
  {{- if $probe.enabled -}}
    {{- "" | nindent 0 }}
    {{- $probeName }}Probe:
    {{- if $probe.custom -}}
      {{- $probe.spec | toYaml | nindent 2 }}
    {{- else }}
      {{- "tcpSocket:" | nindent 2 }}
        {{- printf "port: %v" $svcPort  | nindent 4 }}
      {{- printf "initialDelaySeconds: %v" $probe.spec.initialDelaySeconds  | nindent 2 }}
      {{- printf "failureThreshold: %v" $probe.spec.failureThreshold  | nindent 2 }}
      {{- printf "timeoutSeconds: %v" $probe.spec.timeoutSeconds  | nindent 2 }}
      {{- printf "periodSeconds: %v" $probe.spec.periodSeconds | nindent 2 }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
