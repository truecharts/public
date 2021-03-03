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
Renders the Ingress objects required by the chart by returning a concatinated list
of the main Ingress and any additionalIngresses.
*/}}
{{- define "common.ingress" -}}
  {{- if .Values.ingress.enabled -}}
    {{- $svcPort := .Values.service.port.port -}}

    {{- /* Generate primary ingress */ -}}
    {{- $ingressValues := .Values.ingress -}}
    {{- $_ := set . "ObjectValues" (dict "ingress" $ingressValues) -}}
    {{- include "common.classes.ingress" . }}

    {{- /* Generate additional ingresses as required */ -}}
    {{- range $index, $extraIngress := .Values.ingress.additionalIngresses }}
      {{- if $extraIngress.enabled -}}
        {{- print ("---") | nindent 0 -}}
        {{- $ingressValues := $extraIngress -}}
        {{- if not $ingressValues.nameSuffix -}}
          {{- $_ := set $ingressValues "nameSuffix" $index -}}
        {{ end -}}
        {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
        {{- include "common.classes.ingress" $ -}}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
