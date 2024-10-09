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
Render all the ports and additionalPorts for a Service object.
*/}}
{{- define "common.classes.service.ports" -}}
  {{- $ports := list -}}
  {{- $values := .values -}}
  {{- $ports = mustAppend $ports $values.port -}}
  {{- range $_ := $values.additionalPorts -}}
    {{- $ports = mustAppend $ports . -}}
  {{- end }}
  {{- if $ports -}}
  ports:
  {{- range $_ := $ports }}
  {{- $protocol := "" -}}
  {{- if or ( eq .protocol "HTTP" ) ( eq .protocol "HTTPS" ) }}
    {{- $protocol = "TCP" -}}
  {{- else }}
    {{- $protocol = .protocol | default "TCP" -}}
  {{- end }}
  - port: {{ .port }}
    targetPort: {{ .targetPort | default .name | default "http" }}
    protocol: {{ $protocol | default "TCP" }}
    name: {{ .name | default "http" }}
    {{- if (and (eq $.svcType "NodePort") (not (empty .nodePort))) }}
    nodePort: {{ .nodePort }}
    {{ end }}
  {{- end -}}
  {{- end -}}
{{- end }}
