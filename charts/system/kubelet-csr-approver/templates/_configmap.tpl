{{/* Define the configmap */}}
{{- define "kubelet-csr-approver.configmap.config" -}}
enabled: true
data:
    {{- if .Values.providerRegex }}
    PROVIDER_REGEX: {{ .Values.providerRegex }}
    {{- end }}
    {{- if .Values.providerIpPrefixes }}
    PROVIDER_IP_PREFIXES: "{{ join "," .Values.providerIpPrefixes }}"
    {{- end }}
    {{- if .Values.maxExpirationSeconds}}
    MAX_EXPIRATION_SECONDS: {{ .Values.maxExpirationSeconds | quote }}
    {{- end }}
    {{- if .Values.bypassDnsResolution}}
    BYPASS_DNS_RESOLUTION: {{ .Values.bypassDnsResolution | quote }}
    {{- end }}
    {{- if .Values.ignoreNonSystemNode}}
    IGNORE_NON_SYSTEM_NODE: {{ .Values.ignoreNonSystemNode | quote }}
    {{- end }}
    {{- if .Values.allowedDnsNames}}
    ALLOWED_DNS_NAMES: {{ .Values.allowedDnsNames | quote }}
    {{- end }}
    {{- if .Values.bypassHostnameCheck}}
    BYPASS_HOSTNAME_CHECK: {{ .Values.bypassHostnameCheck | quote }}
    {{- end }}
    {{- with .Values.env }}
    {{ toYaml . | nindent 12 }}
    {{- end }}

{{- end -}}