{{- define "tfa.args" -}}
args:
  - --log-level={{ .Values.tfaAppOptions.logLevel }}
  - --log-format={{ .Values.tfaAppOptions.logFormat }}
  {{- if .Values.tfaAuthOptions.authHost }}
  - --auth-host={{ .Values.tfaAuthOptions.authHost }}
  {{- end }}
  {{- range .Values.tfaCookieOptions.cookieDomain }}
  - --cookie-domain={{ . }}
  {{- end }}
  {{- if .Values.tfaCookieOptions.insecureCookie }}
  - --insecure-cookie
  {{- end }}
  - --cookie-name={{ .Values.tfaCookieOptions.cookieName }}
  - --csrf-cookie-name={{ .Values.tfaCookieOptions.csrfCookieName }}
  - --default-action={{ .Values.tfaAuthOptions.defaultAction }}
  - --default-provider={{ .Values.tfaAuthOptions.defaultProvider }}
  {{- range .Values.tfaAuthOptions.domain }}
  - --domain={{ . }}
  {{- end }}
  - --lifetime={{ .Values.tfaCookieOptions.lifetime }}
  {{- if .Values.tfaAuthOptions.logoutRedirect }}
  - --logout-redirect={{ .Values.tfaAuthOptions.logoutRedirect }}
  {{- end }}
  - --url-path={{ .Values.tfaAuthOptions.urlPath }}
  - --secret={{ .Values.tfaAppOptions.secret }}
  {{- range .Values.tfaAuthOptions.whitelist }}
  - --whitelist={{ . }}
  {{- end }}
  - --port={{ .Values.tfaAppOptions.port }}
  {{- range .Values.tfaAuthOptions.rules }}
  - --{{ . }}
  {{- end }}
{{- end -}}
