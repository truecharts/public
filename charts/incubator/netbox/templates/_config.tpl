{{/* Define the configmap */}}
{{- define "netbox.config" -}}

{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
{{- end -}}
