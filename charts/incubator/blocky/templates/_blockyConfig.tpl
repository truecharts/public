{{/* Define the configmap */}}
{{- define "blocky.configmap" -}}

{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  tc-config.yaml: |
    redis:
      address: {{ printf "%v-%v" .Release.Name "redis" }}:6379
      password: {{ .Values.redis.redisPassword | trimAll "\"" }}
      database: 0
      required: true
      connectionAttempts: 10
      connectionCooldown: 3s
{{- if .Values.blocky.enablePrometheus }}
    prometheus:
      enable: true
      path: /metrics
{{- end }}
    blocking:
      whiteLists:
        ads:
          - whitelist.txt
          - |
            # inline definition with YAML literal block scalar style
      blackLists:
        ads:
          - blackist.txt
          - |
            # inline definition with YAML literal block scalar style
{{- .Values.blockyConfig | toYaml | nindent 4 }}
{{- if .Values.blockyWhitelist }}
  whitelist.txt: |
{{- .Values.blockyWhitelist  | nindent 4 }}
{{- end }}
{{- if .Values.blockyBlacklist }}
  blacklist.txt: |
{{- .Values.blockyBlacklist  | nindent 4 }}
{{- end }}
{{- end -}}
