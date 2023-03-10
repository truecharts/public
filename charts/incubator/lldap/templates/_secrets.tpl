{{/* Define the secrets */}}
{{- define "lldap.secrets" -}}

{{- $jwtSecret := "" }}
{{- $jwtSecret = .Values.lldap.configuration.jwt | default (randAlphaNum 48) | quote }}
{{- end -}}

{{- $userPassword := "" }}
{{- $userPassword = .Values.lldap.configuration.password | quote }}
{{- end -}}

data:
  placeholder: placeholdervalue
  {{- if ne $jwtSecret "" }}
  LLDAP_JWT_SECRET: {{ $jwtSecret }}
  {{- end }}
  {{- if ne $smtpUser "" }}
  LLDAP_LDAP_USER_PASS: {{ $userPassword }}
  SMTP_PASSWORD: {{ required "Must specify user password" .Values.lldap.configuration.password | quote }}
  {{- end }}
{{- end -}}