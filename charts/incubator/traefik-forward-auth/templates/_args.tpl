{{- define "tfa.args" -}}
args:
  - --log-level={{ .Values.tfa-app-options.log-level }}
  - --log-format={{ .Values.tfa-app-options.log-format }}
  {{- if .Values.tfa-auth-options.auth-host }}
  - --auth-host={{ .Values.tfa-auth-options.auth-host }}
  {{- end }}
  {{- range .Values.tfa-cookie-options.cookie-domain }}
  - --cookie-domain={{ . }}
  {{- end }}
  {{- if .Values.tfa-cookie-options.insecure-cookie }}
  - --insecure-cookie
  {{- end }}
  - --cookie-name={{ .Values.tfa-cookie-options.cookie-name }}
  - --csrf-cookie-name={{ .Values.tfa-cookie-options.csrf-cookie-name }}
  - --default-action={{ .Values.tfa-auth-options.default-action }}
  - --default-provider={{ .Values.tfa-auth-options.default-provider }}
  {{- range .Values.tfa-auth-options.domain }}
  - --domain={{ . }}
  {{- end }}
  - --lifetime={{ .Values.tfa-cookie-options.lifetime }}
  {{- if .Values.tfa-auth-options.logout-redirect }}
  - --logout-redirect={{ .Values.tfa-auth-options.logout-redirect }}
  {{- end }}
  {{- if .Values.tfa-auth-options.url-path }}
  - --url-path={{ .Values.tfa-auth-options.url-path }}
  {{- end }}
  - --url-path={{ .Values.tfa-app-options.secret }}
  {{- range .Values.tfa-auth-options.whitelist }}
  - --whitelist={{ . }}
  {{- end }}
  - --port={{ .Values.tfa-app-options.port }}
  {{- range .Values.tfa-auth-options.rules }}
  - --{{ . }}
  {{- end }}
{{- end -}}
