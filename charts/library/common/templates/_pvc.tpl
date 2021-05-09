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
Renders the PersistentVolumeClaim objects required by the chart by returning a concatinated list
of all the entries of the persistence key.
*/}}
{{- define "common.pvc" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $index, $PVC := .Values.persistence }}
    {{- if and $PVC.enabled (not (or $PVC.emptyDir $PVC.existingClaim)) -}}
      {{- $persistenceValues := $PVC -}}
      {{- if not $persistenceValues.nameSuffix -}}
        {{- $_ := set $persistenceValues "nameSuffix" $index -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "persistence" $persistenceValues) -}}
      {{- print ("---") | nindent 0 -}}
      {{- include "common.classes.pvc" $ -}}
    {{- end }}
  {{- end }}
{{- end }}
