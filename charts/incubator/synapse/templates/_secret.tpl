{{/* Define the configs */}}
{{- define "synapse.secret" -}}
{{- $pgHost := printf "%v-cnpg-main-rw" (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $previous := lookup "v1" "Secret" .Release.Namespace "synapse-secret-macaroon" }}
{{- $msk := randAlphaNum 50 }}
{{- if $previous }}
{{- $msk = ( index $previous.data "key" ) | b64dec }}
{{- end }}
enabled: true
data:
  key: {{ $msk | b64enc }}
---
data:
  secret.yaml: |
    {{- if .Values.mail.enabled }}
    email:
      enable_notifs: {{ .Values.mail.enabled }}
      notif_from: {{ .Values.mail.from }}
      smtp_host: {{ .Values.mail.host }}
      smtp_port: {{ .Values.mail.port }}
      smtp_user: {{ .Values.mail.username }}
      smtp_pass: {{ .Values.mail.password }}
      require_transport_security: {{ .Values.mail.requireTransportSecurity }}
    {{- end }}

    database:
        name: "psycopg2"
        args:
          user: "{{ .Values.cnpg.main.user }}"
          password: "{{ .Values.cnpg.main.creds.password }}"
          database: "{{ .Values.cnpg.main.database }}"
          host: "{{ printf "%v:5432" $pgHost }}"
          port: "5432"
          cp_min: 5
          cp_max: 10
          sslmode: "disable"

    {{- if .Values.matrix.sharedSecret }}
    registration_shared_secret: {{ .Values.matrix.sharedSecret }}
    {{- end }}

    macaroon_secret_key: {{ $msk }}

    {{- if .Values.coturn.enabled -}}
    turn_shared_secret: {{ include "matrix.coturn.sharedSecret" . }}
    {{- end }}

{{- end }}
