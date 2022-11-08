{{- define "tc.common.lib.util.manifest.update" -}}
{{- if .Values.manifests.enabled }}
{{- $fullName := include "tc.common.names.fullname" . -}}
---
apiVersion: batch/v1
kind: Job
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ $fullName }}-manifests
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-6"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
spec:
  template:
    spec:
      serviceAccountName: {{ $fullName }}-manifests
      tolerations:
        - key: "ix-svc-start"
          operator: "Exists"
          effect: "NoExecute"
      containers:
        - name: {{ $fullName }}-manifests
          image: {{ .Values.ubuntuImage.repository }}:{{ .Values.ubuntuImage.tag }}
          command:
            - "/bin/sh"
            - "-c"
            - |
              /bin/bash <<'EOF'
              echo "installing manifests..."
              kubectl apply --server-side --force-conflicts -k https://github.com/truecharts/manifests/{{ if .Values.manifests.staging }}staging{{ else }}manifests{{ end }} {{ if .Values.manifests.nonBlocking }}|| echo "Manifest application failed..." {{ end }}
              EOF
      restartPolicy: Never
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ $fullName }}-manifests
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-7"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
rules:
  - apiGroups:  ["*"]
    resources:  ["*"]
    verbs:  ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ $fullName }}-manifests
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-7"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ $fullName }}-manifests
subjects:
  - kind: ServiceAccount
    name: {{ $fullName }}-manifests
    namespace: {{ .Release.Namespace }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $fullName }}-manifests
  namespace: {{ .Release.Namespace }}
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-7"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
{{- end }}
{{- end -}}
