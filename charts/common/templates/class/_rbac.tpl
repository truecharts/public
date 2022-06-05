{{/*
This template serves as a blueprint for rbac objects that are created
using the common library.
*/}}
{{- define "tc.common.class.rbac" -}}
  {{- $targetName := include "tc.common.names.fullname" . }}
  {{- $fullName := include "tc.common.names.fullname" . -}}
  {{- $rbacName := $fullName -}}
  {{- $values := .Values.rbac -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.rbac -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

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
    name: {{ default (include "tc.common.names.serviceAccountName" .) $values.serviceAccountName }}
    namespace: {{ .Release.Namespace }}
  {{- with $values.subjects }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end -}}
