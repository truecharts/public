{{- define "tc.v1.common.lib.util.manifest.manage" -}}
{{- if .Values.manifests.enabled }}
{{- $fullName := include "ix.v1.common.names.fullname" . }}
---
apiVersion: batch/v1
kind: Job
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ $fullName }}-manifests
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-6"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
spec:
  template:
    spec:
      serviceAccountName: {{ $fullName }}-manifests
      containers:
        - name: {{ $fullName }}-manifests
          image: {{ .Values.kubectlImage.repository }}:{{ .Values.kubectlImage.tag }}
          securityContext:
            runAsUser: 568
            runAsGroup: 568
            readOnlyRootFilesystem: true
            runAsNonRoot: true
          command:
            - "/bin/sh"
            - "-c"
            - |
              /bin/sh <<'EOF'
              echo "installing manifests..."
              kubectl apply --server-side --force-conflicts --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/{{ if .Values.manifests.staging }}staging{{ else }}manifests{{ end }} || kubectl apply --server-side --force-conflicts --grace-period 30 -k https://github.com/truecharts/manifests/{{ if .Values.manifests.staging }}staging{{ else }}manifests || echo "job failed..."{{ end }}
              kubectl wait --namespace metallb-system --for=condition=ready pod --selector=app=metallb --timeout=90s || echo "metallb-system wait failed..."
              kubectl wait --namespace cert-manager --for=condition=ready pod --selector=app=cert-manager --timeout=90s || echo "cert-manager wait failed..."
              cmctl check api --wait=2m || echo "cmctl wait failed..."
              EOF
          volumeMounts:
            - name: {{ $fullName }}-manifests-temp
              mountPath: /tmp
            - name: {{ $fullName }}-manifests-home
              mountPath: /home/apps/
      restartPolicy: Never
      volumes:
        - name: {{ $fullName }}-manifests-temp
          emptyDir: {}
        - name: {{ $fullName }}-manifests-home
          emptyDir: {}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ $fullName }}-manifests
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-7"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
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
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
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
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
{{- end }}
{{- end -}}
