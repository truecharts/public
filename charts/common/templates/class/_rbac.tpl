{{/*
This template serves as a blueprint for rbac objects that are created
using the common library.
*/}}
{{- define "tc.common.class.rbac" -}}
  {{- $fullName := include "tc.common.names.fullname" . -}}
  {{- $saName := $fullName -}}
  {{- $rbacName := $fullName -}}
  {{- $values := .Values.rbac -}}
  {{- $saValues := .Values.serviceAccount -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.rbac -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $saName = printf "%v-%v" $saName $values.nameOverride -}}
    {{- if not (hasKey $saValues $values.nameOverride) -}}
      {{- $saName = "default" -}}
    {{- end }}
  {{- end }}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $rbacName = printf "%v-%v" $rbacName $values.nameOverride -}}
  {{- end }}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ $rbacName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
    {{- with $values.labels }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
  annotations:
    {{- with (merge ($values.annotations | default dict) (include "tc.common.annotations" $ | fromYaml)) }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
{{- with $values.rules }}
rules:
  {{- tpl ( toYaml . ) $ | nindent 4 }}
{{- end}}

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ $rbacName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
    {{- with $values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  annotations:
    {{- with (merge ($values.annotations | default dict) (include "tc.common.annotations" $ | fromYaml)) }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ $rbacName }}
subjects:
  - kind: ServiceAccount
    name: {{ $saName }}
    namespace: {{ .Release.Namespace }}
  {{- with $values.subjects }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end -}}
