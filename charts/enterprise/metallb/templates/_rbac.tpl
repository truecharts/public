{{/* Define the rbac */}}
{{- define "metallb.rbac" -}}
{{- if .Values.metallb.rbac.create -}}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ include "tc.common.names.fullname" . }}:controller
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
rules:
- apiGroups: [""]
  resources: ["services"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["services/status"]
  verbs: ["update"]
- apiGroups: [""]
  resources: ["events"]
  verbs: ["create", "patch"]
- apiGroups: ["admissionregistration.k8s.io"]
  resources: ["validatingwebhookconfigurations", "mutatingwebhookconfigurations"]
  verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
- apiGroups: ["apiextensions.k8s.io"]
  resources: ["customresourcedefinitions"]
  verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
- apiGroups: ["authentication.k8s.io"]
  resources: ["tokenreviews"]
  verbs: ["create"]
- apiGroups: ["authorization.k8s.io"]
  resources: ["subjectaccessreviews"]
  verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ include "tc.common.names.fullname" . }}:speaker
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
rules:
- apiGroups: [""]
  resources: ["services", "endpoints", "nodes"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["discovery.k8s.io"]
  resources: ["endpointslices"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["events"]
  verbs: ["create", "patch"]
- apiGroups: ["authentication.k8s.io"]
  resources: ["tokenreviews"]
  verbs: ["create"]
- apiGroups: ["authorization.k8s.io"]
  resources: ["subjectaccessreviews"]
  verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{ include "tc.common.names.fullname" . }}-pod-lister
  labels: {{- include "tc.common.labels" $ | nindent 4 }}
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["list"]
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["addresspools"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["bfdprofiles"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["bgppeers"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["l2advertisements"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["bgpadvertisements"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["ipaddresspools"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["communities"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{ include "tc.common.names.fullname" . }}-controller
  labels: {{- include "tc.common.labels" $ | nindent 4 }}
rules:
{{- if .Values.speaker.memberlist.enabled }}
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["create", "get", "list", "watch"]
- apiGroups: [""]
  resources: ["secrets"]
  resourceNames: [{{ ( printf "%s-memberlist" ( include "tc.common.names.fullname" . ) ) | quote }}]
  verbs: ["list"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  resourceNames: ["{{ include "tc.common.names.fullname" . }}-controller"]
  verbs: ["get"]
{{- end }}
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["addresspools"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["ipaddresspools"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["metallb.io"]
  resources: ["bgppeers"]
  verbs: ["get", "list"]
- apiGroups: ["metallb.io"]
  resources: ["bgpadvertisements"]
  verbs: ["get", "list"]
- apiGroups: ["metallb.io"]
  resources: ["l2advertisements"]
  verbs: ["get", "list"]
- apiGroups: ["metallb.io"]
  resources: ["communities"]
  verbs: ["get", "list","watch"]
- apiGroups: ["metallb.io"]
  resources: ["bfdprofiles"]
  verbs: ["get", "list","watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ include "tc.common.names.fullname" . }}:controller
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
subjects:
- kind: ServiceAccount
  name: {{ include "tc.common.names.serviceAccountName" . }}
  namespace: {{ .Release.Namespace }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ include "tc.common.names.fullname" . }}:controller
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ include "tc.common.names.fullname" . }}:speaker
  labels:
    {{- include "tc.common.labels" $ | nindent 4 }}
subjects:
- kind: ServiceAccount
  name: {{ include "tc.common.names.fullname" . }}-speaker
  namespace: {{ .Release.Namespace }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ include "tc.common.names.fullname" . }}:speaker
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: {{ include "tc.common.names.fullname" . }}-pod-lister
  labels: {{- include "tc.common.labels" $ | nindent 4 }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: {{ include "tc.common.names.fullname" . }}-pod-lister
subjects:
- kind: ServiceAccount
  name: {{ include "tc.common.names.fullname" . }}-speaker
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: {{ include "tc.common.names.fullname" . }}-controller
  labels: {{- include "tc.common.labels" $ | nindent 4 }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: {{ include "tc.common.names.fullname" . }}-controller
subjects:
- kind: ServiceAccount
  name: {{ include "tc.common.names.serviceAccountName" . }}
{{- end -}}
{{- end -}}
