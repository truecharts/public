{{/* Define the configmap */}}
{{- define "snowflake.args" -}}
args:
  {{- with .Values.snowflake.ephemeral_ports_range }}
  - "-ephemeral_ports_range"
  - {{ . | quote }}
  {{- end }}
  {{- if .Values.snowflake.allow_non_tls_relay }}
  - "-allow-non-tls-relay"
  {{- end }}
  {{- with .Values.allowed_relay_hostname_pattern }}
  - "-allowed-relay-hostname-pattern"
  - {{ . | quote }}
  {{- end }}
  {{- with .Values.snowflake.broker }}
  - "-broker"
  - {{ . | quote }}
  {{- end }}
  {{- with .Values.snowflake.capacity }}
  - "-capacity"
  - {{ . | quote }}
  {{- end }}
  {{- if .Values.snowflake.keep_local_addresses }}
  - "-keep-local-addresses"
  {{- end }}
{{- end -}}
