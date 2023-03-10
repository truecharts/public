{{/* Define the configmap */}}
{{- define "lldap.configmap" -}}
enabled: true
data:
    LLDAP_BASE_DN: {{ .Values.lldap.basedn | quote }}
    {{- end }}
{{- end }}
