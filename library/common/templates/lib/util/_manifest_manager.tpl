{{- define "tc.v1.common.lib.util.manifest.manage" -}}
{{- if .Values.manifestManager.enabled }}
{{- $fullName := include "tc.v1.common.lib.chart.names.fullname" . }}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ $fullName }}-manifests
  namespace: {{ .Release.Namespace }}
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-6"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
spec:
  template:
    spec:
      automountServiceAccountToken: true
      serviceAccountName: {{ $fullName }}-manifests
      dnsConfig:
        options:
          - name: ndots
            value: "1"
      containers:
        - name: {{ $fullName }}-manifests
          image: {{ .Values.kubectlImage.repository }}:{{ .Values.kubectlImage.tag }}
          securityContext:
            runAsUser: 568
            runAsGroup: 568
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            allowPrivilegeEscalation: false
            privileged: false
            seccompProfile:
              type: RuntimeDefault
            capabilities:
              add: []
              drop:
                - ALL
          resources:
            requests:
              cpu: 10m
              memory: 50Mi
            limits:
              cpu: 4000m
              memory: 8Gi
          livenessProbe:
            exec:
              command:
              - cat
              - /tmp/healthy
            initialDelaySeconds: 10
            failureThreshold: 60
            successThreshold: 1
            timeoutSeconds: 5
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
              - cat
              - /tmp/healthy
            initialDelaySeconds: 10
            failureThreshold: 60
            successThreshold: 2
            timeoutSeconds: 5
            periodSeconds: 10
          startupProbe:
            exec:
              command:
              - cat
              - /tmp/healthy
            initialDelaySeconds: 10
            failureThreshold: 60
            successThreshold: 1
            timeoutSeconds: 2
            periodSeconds: 5
          command:
            - "/bin/sh"
            - "-c"
            - |
              /bin/sh <<'EOF'
              touch /tmp/healthy
              echo "Installing manifests..."
              {{- $branch := "manifests" -}}
              {{- $handleErr := "|| echo 'Job succeeded...'" -}}
              {{- if .Values.manifestManager.staging -}}
                {{- $branch = "staging" -}}
                {{- $handleErr = "&& echo 'Job failed...'" -}}
              {{- end }}

              {{- if .Values.manifestManager.install }}
              kubectl apply --server-side --force-conflicts --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/{{ $branch }} || \
              kubectl apply --server-side --force-conflicts --grace-period 30 -k https://github.com/truecharts/manifests/{{ $branch }} {{ $handleErr }}

              echo "Install finished..."
              {{- end }}

              {{- if .Values.manifestManager.check }}
              echo "Starting waits and checks..."
              kubectl delete pod --field-selector=status.phase==Succeeded -n cnpg-system || echo "Delete of Completed Pods failed..."
              kubectl delete pod --field-selector=status.phase==Failed -n cnpg-system || echo "Delete of Failed Pods failed..."
              kubectl wait --namespace cnpg-system --for=condition=ready pod --selector=app.kubernetes.io/name=cloudnative-pg --timeout=60s || echo "metallb-system wait failed..."

              kubectl delete pod --field-selector=status.phase==Succeeded -n metallb-system || echo "Delete of Completed Pods failed..."
              kubectl delete pod --field-selector=status.phase==Failed -n metallb-system || echo "Delete of Failed Pods failed..."
              kubectl wait --namespace metallb-system --for=condition=ready pod --selector=app=metallb --timeout=60s || echo "metallb-system wait failed..."

              kubectl delete pod --field-selector=status.phase==Succeeded -n cert-manager || echo "Delete of Completed Pods failed..."
              kubectl delete pod --field-selector=status.phase==Failed -n cert-manager || echo "Delete of Failed Pods failed..."
              kubectl wait --namespace cert-manager --for=condition=ready pod --selector=app.kubernetes.io/instance=cert-manager --timeout=60s || echo "cert-manager wait failed..."

              cmctl check api --wait=1m || echo "cmctl wait failed..."

              echo "Checks finished..."
              {{- end }}

              {{- if .Values.manifestManager.delete -}}
              echo "Deleting manifests..."
              kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete && kubectl delete --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete || \
              kubectl delete --force --grace-period 30 -k https://github.com/truecharts/manifests/delete {{ $handleErr }}
              echo "Deletion finished..."
              {{- end }}
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
automountServiceAccountToken: false
{{- end }}
{{- end -}}
