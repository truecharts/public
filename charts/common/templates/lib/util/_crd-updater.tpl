{{- define "tc.common.lib.util.crd.update" -}}
{{- $fullName := include "tc.common.names.fullname" . -}}
{{- if .Values.updateCRD }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ $fullName }}-crds
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
data:
{{- range $path, $bytes := .Files.Glob "crds/*.yaml" }}
  {{ $path | trimPrefix "crds/" }}: {{ $.Files.Get $path  | quote }}
{{- end }}
---
apiVersion: batch/v1
kind: Job
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ $fullName }}-crds
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-4"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
spec:
  template:
    spec:
      serviceAccountName: {{ $fullName }}-crds
      containers:
        - name: {{ $fullName }}-crds
          image: {{ .Values.multiinitImage.repository }}:{{ .Values.multiinitImage.tag }}
          volumeMounts:
            - name: {{ $fullName }}-crds
              mountPath: /etc/crds
              readOnly: true
          command: ["kubectl", "apply", "-f", "/etc/crds"]
      volumes:
        - name: {{ $fullName }}-crds
          configMap:
            name: {{ $fullName }}-crds
      restartPolicy: OnFailure
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ $fullName }}-crds
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
rules:
  - apiGroups: ["apiextensions.k8s.io"]
    resources: ["customresourcedefinitions"]
    verbs: ["create", "get", "list", "watch", "patch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ $fullName }}-crds
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ $fullName }}-crds
subjects:
  - kind: ServiceAccount
    name: {{ $fullName }}-crds
    namespace: {{ .Release.Namespace }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $fullName }}-crds
  namespace: {{ .Release.Namespace }}
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
{{- end }}
{{- end -}}
