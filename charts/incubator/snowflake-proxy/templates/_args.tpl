{{/* Define the configmap */}}
{{- define "snowflake.args" -}}
args:
  {{- with .Values.snowflake.ephemeral_ports_range }}
  - "-ephemeral_ports_range {{ . }}"
  {{- end }}
  {{- if .Values.snowflake.allow_non_tls_relay }}
  - "-allow-non-tls-relay"
  {{- end }}
  {{- with .Values.allowed_relay_hostname_pattern }}
  - "-allowed-relay-hostname-pattern {{ . }}"
  {{- end }}
  {{- with .Values.snowflake.broker }}
  - "-broker {{ . }}"
  {{- end }}
  {{- with .Values.snowflake.capacity }}
  - "-capacity {{ int . }}"
  {{- end }}
  {{- if .Values.snowflake.keep_local_addresses }}
  - "-keep-local-addresses"
  {{- end }}
  {{- with .Values.snowflake.nat_retest_interval }}
  - "-nat-retest-interval {{ . }}"
  {{- end }}
  {{- with .Values.snowflake.relay }}
  - "-relay {{ . }}"
  {{- end }}
  {{- with .Values.snowflake.stun }}
  - "-stun {{ . }}"
  {{- end }}
  {{- with .Values.snowflake.summary_interval }}
  - "-summary-interval {{ . }}"
  {{- end }}
  {{- with .Values.snowflake.unsafe_logging }}
  - "-unsafe-logging"
  {{- end }}
  {{- with .Values.snowflake.verbose }}
  - "-verbose"
  {{- end }}
  {{- with .Values.snowflake.log }}
  - "-log {{ . }}"
  {{- end }}
{{- end -}}
