{{/* Define the configmap */}}
{{- define "openproject.config" -}}

{{- $commonConfigName := printf "%s-common-config" (include "tc.common.names.fullname" .) }}
{{- $mainConfigName := printf "%s-main-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $commonConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  OPENPROJECT_CACHE__MEMCACHE__SERVER: {{ printf "%v-%v:%v" .Release.Name "memcached" "11211" }}
  OPENPROJECT_RAILS__CACHE__STORE: memcache
  OPENPROJECT_CACHE__NAMESPACE: openproject
  {{/* User Defined */}}
  OPENPROJECT_CACHE__EXPIRES__IN__SECONDS: {{ .Values.openproject.cache.expires_in_seconds | quote }}
  OPENPROJECT_EDITION: {{ .Values.openproject.edition }}
  OPENPROJECT_HOST__NAME: {{ .Values.openproject.hostname }}
  OPENPROJECT_HTTPS: {{ .Values.openproject.enable_https | quote }}

{{- end -}}
