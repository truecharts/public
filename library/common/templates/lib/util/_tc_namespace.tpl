{{- define "tc.v1.common.lib.util.tcnamespace" -}}
  {{- if $.Values.global.createTCNamespace -}}
    {{/* Only create it if it does not exist */}}
    {{- if not (lookup "v1" "Namespace" "tc-system" "") }}
---
apiVersion: v1
kind: Namespace
metadata:
  name: tc-system
  annotations:
    "helm.sh/resource-policy": keep
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "-20"
    "helm.sh/hook-delete-policy": hook-failed
    {{- end -}}
  {{- end -}}
{{- end -}}
