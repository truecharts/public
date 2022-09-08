{{/* Define the configmap */}}
{{- define "umami.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: umami-paths
data:
  HASH_SALT: "/secrets/HASH_SALT"

{{- end -}}
