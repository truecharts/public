{{/*
This template serves as a blueprint for ServiceAccount objects that are created
using the common library.
*/}}
{{- define "tc.common.class.serviceAccount" -}}
  {{- $fullName := include "tc.common.names.fullname" . -}}
  {{- $saName := $fullName -}}
  {{- $values := .Values.serviceAccount -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.serviceAccount -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $saName = printf "%v-%v" $saName $values.nameOverride -}}
  {{- end }}

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $saName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  {{- with $values.annotations }}
  annotations:
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
{{- end }}
