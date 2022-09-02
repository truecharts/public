{{- define "tailscale.rbac" -}}

{{- $rbacName := printf "%s-tailscale-addon" (include "tc.common.names.fullname" .) -}}
{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ $rbacName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  annotations:
  {{- with .Values.addons.vpn.tailscale.annotations }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
rules:
  - apiGroups:
      - ""
    resources:
      - "secrets"
    verbs:
      - "create"
  - apiGroups:
      - ""
    resources:
      - "secrets"
    resourceNames:
      - '{{ $secretName }}'
    verbs:
      - "get"
      - "update"
{{- end -}}
