{{/* Define the secret */}}
{{- define "tfa.secrets" -}}

enabled: true
data:
  PROVIDERS_GOOGLE_CLIENT_ID: {{ .Values.tfaGoogleOptions.clientId | trimAll "\"" }}
  PROVIDERS_GOOGLE_CLIENT_SECRET: {{ .Values.tfaGoogleOptions.clientSecret | trimAll "\"" }}
  PROVIDERS_GOOGLE_PROMPT: {{ .Values.tfaGoogleOptions.prompt | trimAll "\"" }}
  PROVIDERS_OIDC_ISSUER_URL: {{ .Values.tfaOidcOptions.issuerUrl | trimAll "\"" }}
  PROVIDERS_OIDC_CLIENT_ID: {{ .Values.tfaOidcOptions.clientId | trimAll "\"" }}
  PROVIDERS_OIDC_CLIENT_SECRET: {{ .Values.tfaOidcOptions.clientSecret | trimAll "\"" }}
  PROVIDERS_OIDC_RESOURCE: {{ .Values.tfaOidcOptions.resource | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_AUTH_URL: {{ .Values.tfaOauthOptions.authUrl | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_TOKEN_URL: {{ .Values.tfaOauthOptions.tokenUrl | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_USER_URL: {{ .Values.tfaOauthOptions.userUrl | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_CLIENT_ID: {{ .Values.tfaOauthOptions.clientId | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_CLIENT_SECRET: {{ .Values.tfaOauthOptions.clientSecret | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_TOKEN_STYLE: {{ .Values.tfaOauthOptions.tokenStyle | trimAll "\"" }}
  PROVIDERS_GENERIC_OAUTH_RESOURCE: {{ .Values.tfaOauthOptions.resource | trimAll "\"" }}
{{- end }}
