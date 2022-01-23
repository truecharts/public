{{/* Define the configs */}}
{{- define "synapse.secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: synapse-secret
  labels:
  {{ include "common.labels" . | nindent 4 }}
  annotations:
    rollme: {{ randAlphaNum 5 | quote }}
stringData:
  {{- $previous := lookup "v1" "Secret" .Release.Namespace "synapse-secret" }}
  {{- $msk := "" }}
  secret.yaml: |
    {{- if .Values.mail.enabled }}
    email:
      enable_notifs: {{ .Values.mail.enabled }}
      notif_from: {{ .Values.mail.from }}
      smtp_host: {{ .Values.mail.external.host }}
      smtp_port: {{ .Values.mail.external.port }}
      smtp_user: {{ .Values.mail.external.username }}
      smtp_pass: {{ .Values.mail.external.password }}
      require_transport_security: {{ .Values.mail.external.requireTransportSecurity }}
    {{- end }}

    database:
        name: "psycopg2"
        args:
          user: "{{ .Values.postgresql.postgresqlUsername }}"
          password: {{ .Values.postgresql.postgresqlPassword }}
          database: "{{ .Values.postgresql.postgresqlDatabase }}"
          host: "{{ printf "%v-%v" .Release.Name "postgresql" }}"
          port: "5432"
          cp_min: 5
          cp_max: 10
          sslmode: "disable"

    {{- if .Values.matrix.registration.sharedSecret }}
    registration_shared_secret: {{ .Values.matrix.registration.sharedSecret }}
    {{- end }}

    {{- if $previous }}
    {{- $msk = ( index $previous.data "macaroon_secret_key" ) | b64dec  }}
    macaroon_secret_key: {{ ( index $previous.data "macaroon_secret_key" ) }}
    {{- else }}
    {{- $msk = randAlphaNum 50 }}
    macaroon_secret_key: {{ $msk | b64enc | quote }}
    {{- end }}

    {{- if .Values.coturn.enabled -}}
    turn_shared_secret: {{ include "matrix.coturn.sharedSecret" . }}
    {{- end }}

{{- end }}
