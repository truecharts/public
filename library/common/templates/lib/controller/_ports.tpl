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
Ports included by the controller.
*/}}
{{- define "common.controller.ports" -}}
{{- $ports := list -}}
    {{/* append the ports for each appAdditionalService - TrueCharts */}}
    {{- if $.Values.services -}}
      {{- range $name, $_ := $.Values.services }}
        {{- if or ( .enabled ) ( eq $name "main" ) -}}
          {{- if eq $name "main" -}}
            {{- $_ := set .port "name" (default "http" .port.name) -}}
          {{- else if kindIs "string" $name -}}
            {{- $_ := set .port "name" (default .port.name | default $name) -}}
            {{- else -}}
            {{- $_ := set .port "name" (required "Missing port.name" .port.name) -}}
          {{- end -}}
          {{- $ports = mustAppend $ports .port -}}
          {{- range $_ := .additionalPorts -}}
            {{/* append the additonalPorts for each additional service */}}
            {{- $ports = mustAppend $ports . -}}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- if $.Values.additionalServices -}}
      {{- range $_ := $.Values.additionalServices }}
        {{- if .enabled -}}
          {{- $_ := set .port "name" (required "Missing port.name" .port.name) -}}
          {{- $ports = mustAppend $ports .port -}}
          {{- range $_ := .additionalPorts -}}
            {{/* append the additonalPorts for each additional service */}}
            {{- $ports = mustAppend $ports . -}}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

{{/* export/render the list of ports */}}
{{- if $ports -}}
ports:
{{- range $_ := $ports }}
{{- $protocol := "" -}}
{{- if or ( eq .protocol "HTTP" ) ( eq .protocol "HTTPS" ) }}
  {{- $protocol = "TCP" -}}
{{- else }}
  {{- $protocol = .protocol | default "TCP" -}}
{{- end }}
- name: {{ required "The port's 'name' is not defined" .name }}
  {{- if and .targetPort (kindIs "string" .targetPort) }}
  {{- fail (printf "Our charts do not support named ports for targetPort. (port name %s, targetPort %s)" .name .targetPort) }}
  {{- end }}
  containerPort: {{ .targetPort | default .port }}
  protocol: {{ $protocol | default "TCP" }}
{{- end -}}
{{- end -}}
{{- end -}}
