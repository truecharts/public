{{/* Define the secret */}}
{{- define "tfa.secret" -}}

{{- $googleSecretName := printf "%s-google-secret" (include "tc.common.names.fullname" .) }}
{{- $oidcSecretName := printf "%s-oidc-secret" (include "tc.common.names.fullname" .) }}
{{- $oauthSecretName := printf "%s-oauth2-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $googleSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PROVIDERS_GOOGLE_CLIENT_ID: {{ .Values.tfaGoogleOptions.clientId | trimAll "\"" | b64enc }}
  PROVIDERS_GOOGLE_CLIENT_SECRET: {{ .Values.tfaGoogleOptions.clientSecret | trimAll "\"" | b64enc }}
  PROVIDERS_GOOGLE_PROMPT: {{ .Values.tfaGoogleOptions.prompt | trimAll "\"" | b64enc }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $oidcSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PROVIDERS_OIDC_ISSUER_URL: {{ .Values.tfaOidcOptions.issuerUrl | trimAll "\"" | b64enc }}
  PROVIDERS_OIDC_CLIENT_ID: {{ .Values.tfaOidcOptions.clientId | trimAll "\"" | b64enc }}
  PROVIDERS_OIDC_CLIENT_SECRET: {{ .Values.tfaOidcOptions.clientSecret | trimAll "\"" | b64enc }}
  PROVIDERS_OIDC_RESOURCE: {{ .Values.tfaOidcOptions.resource | trimAll "\"" | b64enc }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $oauthSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PROVIDERS_GENERIC_OAUTH_AUTH_URL: {{ .Values.tfaOauthOptions.authUrl | trimAll "\"" | b64enc }}
  PROVIDERS_GENERIC_OAUTH_TOKEN_URL: {{ .Values.tfaOauthOptions.tokenUrl | trimAll "\"" | b64enc }}
  PROVIDERS_GENERIC_OAUTH_USER_URL: {{ .Values.tfaOauthOptions.userUrl | trimAll "\"" | b64enc }}
  PROVIDERS_GENERIC_OAUTH_CLIENT_ID: {{ .Values.tfaOauthOptions.clientId | trimAll "\"" | b64enc }}
  PROVIDERS_GENERIC_OAUTH_CLIENT_SECRET: {{ .Values.tfaOauthOptions.clientSecret | trimAll "\"" | b64enc }}
  PROVIDERS_GENERIC_OAUTH_TOKEN_STYLE: {{ .Values.tfaOauthOptions.tokenStyle | trimAll "\"" | b64enc }}
  PROVIDERS_GENERIC_OAUTH_RESOURCE: {{ .Values.tfaOauthOptions.resource | trimAll "\"" | b64enc }}

---

{{- end }}
