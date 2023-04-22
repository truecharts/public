{{/* Define the configmap */}}
{{- define "n8n.configmap" -}}
enabled: true
data:
  {{/* External Hooks */}}
  {{- if .Values.externalhooks.EXTERNAL_HOOK_FILES }}
  EXTERNAL_HOOK_FILES: {{ .Values.externalhooks.EXTERNAL_HOOK_FILES | quote }}
  {{- end }}
  {{/* User Management */}}
  {{- if .Values.usermanagement.N8N_USER_MANAGEMENT_DISABLED }}
  N8N_USER_MANAGEMENT_DISABLED: {{ .Values.usermanagement.N8N_USER_MANAGEMENT_DISABLED | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_EMAIL_MODE }}
  N8N_EMAIL_MODE: {{ .Values.usermanagement.N8N_EMAIL_MODE | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_SMTP_HOST }}
  N8N_SMTP_HOST: {{ .Values.usermanagement.N8N_SMTP_HOST | quote }}
  {{- end }}
  {{- if hasKey .Values.usermanagement "N8N_SMTP_PORT" }}
  {{- if or .Values.usermanagement.N8N_SMTP_PORT (eq 0 (int .Values.usermanagement.N8N_SMTP_PORT)) }}
  N8N_SMTP_PORT: {{ .Values.usermanagement.N8N_SMTP_PORT | quote }}
  {{- end }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_SMTP_USER }}
  N8N_SMTP_USER: {{ .Values.usermanagement.N8N_SMTP_USER | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_SMTP_PASS }}
  N8N_SMTP_PASS: {{ .Values.usermanagement.N8N_SMTP_PASS | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_SMTP_SENDER }}
  N8N_SMTP_SENDER: {{ .Values.usermanagement.N8N_SMTP_SENDER | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_SMTP_SSL }}
  N8N_SMTP_SSL: {{ .Values.usermanagement.N8N_SMTP_SSL | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_UM_EMAIL_TEMPLATES_INVITE }}
  N8N_UM_EMAIL_TEMPLATES_INVITE: {{ .Values.usermanagement.N8N_UM_EMAIL_TEMPLATES_INVITE | quote }}
  {{- end }}
  {{- if .Values.usermanagement.N8N_UM_EMAIL_TEMPLATES_PWRESET }}
  N8N_UM_EMAIL_TEMPLATES_PWRESET: {{ .Values.usermanagement.N8N_UM_EMAIL_TEMPLATES_PWRESET | quote }}
  {{- end }}
  {{/* Timezone and Locale */}}
  {{- if .Values.timezoneandlocale.N8N_DEFAULT_LOCALE }}
  N8N_DEFAULT_LOCALE: {{ .Values.timezoneandlocale.N8N_DEFAULT_LOCALE | quote }}
  {{- end }}
  {{/* Workflows */}}
  {{- if .Values.workflows.WORKFLOWS_DEFAULT_NAME }}
  WORKFLOWS_DEFAULT_NAME: {{ .Values.workflows.WORKFLOWS_DEFAULT_NAME | quote }}
  {{- end }}
  {{- if .Values.workflows.N8N_ONBOARDING_FLOW_DISABLED }}
  N8N_ONBOARDING_FLOW_DISABLED: {{ .Values.workflows.N8N_ONBOARDING_FLOW_DISABLED | quote }}
  {{- end }}
  {{- if .Values.workflows.N8N_WORKFLOW_TAGS_DISABLED }}
  N8N_WORKFLOW_TAGS_DISABLED: {{ .Values.workflows.N8N_WORKFLOW_TAGS_DISABLED | quote }}
  {{- end }}
  {{/* Security */}}
  {{- if .Values.n8n_security.N8N_BLOCK_ENV_ACCESS_IN_NODE }}
  N8N_BLOCK_ENV_ACCESS_IN_NODE: {{ .Values.n8n_security.N8N_BLOCK_ENV_ACCESS_IN_NODE | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_AUTH_EXCLUDE_ENDPOINTS }}
  N8N_AUTH_EXCLUDE_ENDPOINTS: {{ .Values.n8n_security.N8N_AUTH_EXCLUDE_ENDPOINTS | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_BASIC_AUTH_ACTIVE }}
  N8N_BASIC_AUTH_ACTIVE: {{ .Values.n8n_security.N8N_BASIC_AUTH_ACTIVE | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_BASIC_AUTH_USER }}
  N8N_BASIC_AUTH_USER: {{ .Values.n8n_security.N8N_BASIC_AUTH_USER | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_BASIC_AUTH_PASSWORD }}
  N8N_BASIC_AUTH_PASSWORD: {{ .Values.n8n_security.N8N_BASIC_AUTH_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_BASIC_AUTH_HASH }}
  N8N_BASIC_AUTH_HASH: {{ .Values.n8n_security.N8N_BASIC_AUTH_HASH | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_AUTH_ACTIVE }}
  N8N_JWT_AUTH_ACTIVE: {{ .Values.n8n_security.N8N_JWT_AUTH_ACTIVE | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_AUTH_HEADER }}
  N8N_JWT_AUTH_HEADER: {{ .Values.n8n_security.N8N_JWT_AUTH_HEADER | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_AUTH_HEADER_VALUE_PREFIX }}
  N8N_JWT_AUTH_HEADER_VALUE_PREFIX: {{ .Values.n8n_security.N8N_JWT_AUTH_HEADER_VALUE_PREFIX | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWKS_URI }}
  N8N_JWKS_URI: {{ .Values.n8n_security.N8N_JWKS_URI | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_ISSUER }}
  N8N_JWT_ISSUER: {{ .Values.n8n_security.N8N_JWT_ISSUER | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_NAMESPACE }}
  N8N_JWT_NAMESPACE: {{ .Values.n8n_security.N8N_JWT_NAMESPACE | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_ALLOWED_TENANT }}
  N8N_JWT_ALLOWED_TENANT: {{ .Values.n8n_security.N8N_JWT_ALLOWED_TENANT | quote }}
  {{- end }}
  {{- if .Values.n8n_security.N8N_JWT_ALLOWED_TENANT_KEY }}
  N8N_JWT_ALLOWED_TENANT_KEY: {{ .Values.n8n_security.N8N_JWT_ALLOWED_TENANT_KEY | quote }}
  {{- end }}
  {{/* Logs */}}
  {{- if .Values.logs.N8N_LOG_LEVEL }}
  N8N_LOG_LEVEL: {{ .Values.logs.N8N_LOG_LEVEL | quote }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_OUTPUT }}
  N8N_LOG_OUTPUT: {{ .Values.logs.N8N_LOG_OUTPUT | quote }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_FILE_COUNT_MAX }}
  N8N_LOG_FILE_COUNT_MAX: {{ .Values.logs.N8N_LOG_FILE_COUNT_MAX | quote }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_FILE_SIZE_MAX }}
  N8N_LOG_FILE_SIZE_MAX: {{ .Values.logs.N8N_LOG_FILE_SIZE_MAX | quote }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_FILE_LOCATION }}
  N8N_LOG_FILE_LOCATION: {{ .Values.logs.N8N_LOG_FILE_LOCATION | quote }}
  {{- end }}
  {{/* Executions */}}
  {{- if .Values.executions.EXECUTIONS_PROCESS }}
  EXECUTIONS_PROCESS: {{ .Values.executions.EXECUTIONS_PROCESS | quote }}
  {{- end }}
  {{- if .Values.executions.EXECUTIONS_MODE }}
  EXECUTIONS_MODE: {{ .Values.executions.EXECUTIONS_MODE | quote }}
  {{- end }}
  {{- if hasKey .Values.executions "EXECUTIONS_TIMEOUT" }}
  {{- if or .Values.executions.EXECUTIONS_TIMEOUT (eq 0 (int .Values.executions.EXECUTIONS_TIMEOUT)) }}
  EXECUTIONS_TIMEOUT: {{ .Values.executions.EXECUTIONS_TIMEOUT | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey .Values.executions "EXECUTIONS_TIMEOUT" }}
  {{- if or .Values.executions.EXECUTIONS_TIMEOUT_MAX (eq 0 (int .Values.executions.EXECUTIONS_TIMEOUT_MAX)) }}
  EXECUTIONS_TIMEOUT_MAX: {{ .Values.executions.EXECUTIONS_TIMEOUT_MAX | quote }}
  {{- end }}
  {{- end }}
  {{- if .Values.executions.EXECUTIONS_DATA_SAVE_ON_ERROR }}
  EXECUTIONS_DATA_SAVE_ON_ERROR: {{ .Values.executions.EXECUTIONS_DATA_SAVE_ON_ERROR | quote }}
  {{- end }}
  {{- if .Values.executions.EXECUTIONS_DATA_SAVE_ON_SUCCESS }}
  EXECUTIONS_DATA_SAVE_ON_SUCCESS: {{ .Values.executions.EXECUTIONS_DATA_SAVE_ON_SUCCESS | quote }}
  {{- end }}
  {{- if .Values.executions.EXECUTIONS_DATA_SAVE_ON_PROGRESS }}
  EXECUTIONS_DATA_SAVE_ON_PROGRESS: {{ .Values.executions.EXECUTIONS_DATA_SAVE_ON_PROGRESS | quote }}
  {{- end }}
  {{- if .Values.executions.EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS }}
  EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS: {{ .Values.executions.EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS | quote }}
  {{- end }}
  {{- if .Values.executions.EXECUTIONS_DATA_PRUNE }}
  EXECUTIONS_DATA_PRUNE: {{ .Values.executions.EXECUTIONS_DATA_PRUNE | quote }}
  {{- end }}
  {{- if hasKey .Values.executions "EXECUTIONS_TIMEOUT" }}
  {{- if or .Values.executions.EXECUTIONS_DATA_MAX_AGE (eq 0 (int .Values.executions.EXECUTIONS_DATA_MAX_AGE)) }}
  EXECUTIONS_DATA_MAX_AGE: {{ .Values.executions.EXECUTIONS_DATA_MAX_AGE | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey .Values.executions "EXECUTIONS_TIMEOUT" }}
  {{- if or .Values.executions.EXECUTIONS_DATA_PRUNE_TIMEOUT ( eq 0 (int .Values.executions.EXECUTIONS_DATA_PRUNE_TIMEOUT)) }}
  EXECUTIONS_DATA_PRUNE_TIMEOUT: {{ .Values.executions.EXECUTIONS_DATA_PRUNE_TIMEOUT | quote }}
  {{- end }}
  {{- end }}
  {{/* Endpoints */}}
  {{- if .Values.endpoints.WEBHOOK_URL }}
  WEBHOOK_URL: {{ .Values.endpoints.WEBHOOK_URL | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_PAYLOAD_SIZE_MAX }}
  N8N_PAYLOAD_SIZE_MAX: {{ .Values.endpoints.N8N_PAYLOAD_SIZE_MAX | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_METRICS }}
  N8N_METRICS: {{ .Values.endpoints.N8N_METRICS | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_METRICS_PREFIX }}
  N8N_METRICS_PREFIX: {{ .Values.endpoints.N8N_METRICS_PREFIX | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_ENDPOINT_REST }}
  N8N_ENDPOINT_REST: {{ .Values.endpoints.N8N_ENDPOINT_REST | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_ENDPOINT_WEBHOOK }}
  N8N_ENDPOINT_WEBHOOK: {{ .Values.endpoints.N8N_ENDPOINT_WEBHOOK | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_ENDPOINT_WEBHOOK_TEST }}
  N8N_ENDPOINT_WEBHOOK_TEST: {{ .Values.endpoints.N8N_ENDPOINT_WEBHOOK_TEST | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_ENDPOINT_WEBHOOK_WAIT }}
  N8N_ENDPOINT_WEBHOOK_WAIT: {{ .Values.endpoints.N8N_ENDPOINT_WEBHOOK_WAIT | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_DISABLE_PRODUCTION_MAIN_PROCESS }}
  N8N_DISABLE_PRODUCTION_MAIN_PROCESS: {{ .Values.endpoints.N8N_DISABLE_PRODUCTION_MAIN_PROCESS | quote }}
  {{- end }}
  {{- if .Values.endpoints.N8N_SKIP_WEBHOOK_DEREGISTRATION_SHUTDOWN }}
  N8N_SKIP_WEBHOOK_DEREGISTRATION_SHUTDOWN: {{ .Values.endpoints.N8N_SKIP_WEBHOOK_DEREGISTRATION_SHUTDOWN | quote }}
  {{- end }}
  {{/* Credentials */}}
  {{- if .Values.credentials.CREDENTIALS_OVERWRITE_DATA }}
  CREDENTIALS_OVERWRITE_DATA: {{ .Values.credentials.CREDENTIALS_OVERWRITE_DATA | quote }}
  {{- end }}
  {{- if .Values.credentials.CREDENTIALS_OVERWRITE_ENDPOINT }}
  CREDENTIALS_OVERWRITE_ENDPOINT: {{ .Values.credentials.CREDENTIALS_OVERWRITE_ENDPOINT | quote }}
  {{- end }}
  {{- if .Values.credentials.CREDENTIALS_DEFAULT_NAME }}
  CREDENTIALS_DEFAULT_NAME: {{ .Values.credentials.CREDENTIALS_DEFAULT_NAME | quote }}
  {{- end }}
  {{/* Deployment */}}
  {{- if .Values.deployment.N8N_HOST }}
  N8N_HOST: {{ .Values.deployment.N8N_HOST | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_EDITOR_BASE_URL }}
  N8N_EDITOR_BASE_URL: {{ .Values.deployment.N8N_EDITOR_BASE_URL | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_CONFIG_FILES }}
  N8N_CONFIG_FILES: {{ .Values.deployment.N8N_CONFIG_FILES | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_DISABLE_UI }}
  N8N_DISABLE_UI: {{ .Values.deployment.N8N_DISABLE_UI | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_ENCRYPTION_KEY }}
  N8N_ENCRYPTION_KEY: {{ .Values.deployment.N8N_ENCRYPTION_KEY | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_PERSONALIZATION_ENABLED }}
  N8N_PERSONALIZATION_ENABLED: {{ .Values.deployment.N8N_PERSONALIZATION_ENABLED | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_VERSION_NOTIFICATIONS_ENABLED }}
  N8N_VERSION_NOTIFICATIONS_ENABLED: {{ .Values.deployment.N8N_VERSION_NOTIFICATIONS_ENABLED | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_TEMPLATES_ENABLED }}
  N8N_TEMPLATES_ENABLED: {{ .Values.deployment.N8N_TEMPLATES_ENABLED | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_TEMPLATES_HOST }}
  N8N_TEMPLATES_HOST: {{ .Values.deployment.N8N_TEMPLATES_HOST | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_DIAGNOSTICS_ENABLED }}
  N8N_DIAGNOSTICS_ENABLED: {{ .Values.deployment.N8N_DIAGNOSTICS_ENABLED | quote }}
  {{- end }}
  {{- if .Values.deployment.N8N_HIRING_BANNER_ENABLED }}
  N8N_HIRING_BANNER_ENABLED: {{ .Values.deployment.N8N_HIRING_BANNER_ENABLED | quote }}
  {{- end }}
{{- end -}}
