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
This template serves as a blueprint for all PersistentVolumeClaim objects that are created
within the common library.
*/}}
{{- define "common.classes.pvc" -}}
{{- $values := .Values.persistence -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.persistence -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $pvcName := include "common.names.fullname" . -}}
{{- if hasKey $values "nameOverride" -}}
  {{- $pvcName = $values.nameOverride -}}
{{- else if hasKey $values "nameSuffix" -}}
  {{- $pvcName = printf "%v-%v" $pvcName $values.nameSuffix -}}
{{ end -}}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $pvcName }}
  {{- if or $values.skipuninstall $values.annotations }}
  annotations:
    {{- if $values.skipuninstall }}
    "helm.sh/resource-policy": keep
    {{- end }}
    {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  labels:
  {{- include "common.labels" . | nindent 4 }}
spec:
  accessModes:
    - {{ required (printf "accessMode is required for PVC %v" $pvcName) $values.accessMode | quote }}
  resources:
    requests:
      storage: {{ required (printf "size is required for PVC %v" $pvcName) $values.size | quote }}
  {{- if $values.storageClass }}
  storageClassName: {{ include "common.storage.class" . }}
  {{- else }}
  storageClassName: {{ ( printf "%v-%v"  "ix-storage-class" .Release.Name ) }}
  {{- end }}
{{- end -}}
