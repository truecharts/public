{{/* Define the configmap */}}
{{- define "snowflake.args" -}}
args:
  {{- with .Values.snowflake.ephemeral_ports_range }}
  - "-ephemeral-ports-range"
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
  - {{ int . | quote }}
  {{- end }}
  {{- if .Values.snowflake.keep_local_addresses }}
  - "-keep-local-addresses"
  {{- end }}
  {{- with .Values.snowflake.nat_retest_interval }}
  - "-nat-retest-interval"
  - {{ . | quote }}
  {{- end }}
  {{- with .Values.snowflake.relay }}
  - "-relay"
  - {{ . | quote }}
  {{- end }}
  {{- with .Values.snowflake.stun }}
  - "-stun"
  - {{ . | quote }}
  {{- end }}
  {{- with .Values.snowflake.summary_interval }}
  - "-summary-interval"
  - {{ . | quote }}
  {{- end }}
  {{- with .Values.snowflake.unsafe_logging }}
  - "-unsafe-logging"
  {{- end }}
  {{- with .Values.snowflake.verbose }}
  - "-verbose"
  {{- end }}
  {{- with .Values.snowflake.log }}
  - "-log"
  - {{ . | quote }}
  {{- end }}
{{- end -}}
