{{/* Define the configmap */}}
{{- define "weblate.configmap" -}}
enabled: true
data:
  {{/* General */}}
  {{- if .Values.weblate.general.WEBLATE_SITE_DOMAIN }}
  WEBLATE_SITE_DOMAIN: {{ .Values.weblate.general.WEBLATE_SITE_DOMAIN | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_SITE_TITLE }}
  WEBLATE_SITE_TITLE: {{ .Values.weblate.general.WEBLATE_SITE_TITLE | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ADMIN_NAME }}
  WEBLATE_ADMIN_NAME: {{ .Values.weblate.general.WEBLATE_ADMIN_NAME | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ADMIN_EMAIL }}
  WEBLATE_ADMIN_EMAIL: {{ .Values.weblate.general.WEBLATE_ADMIN_EMAIL | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ADMIN_PASSWORD }}
  WEBLATE_ADMIN_PASSWORD: {{ .Values.weblate.general.WEBLATE_ADMIN_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.weblate.WEBLATE_AUTO_UPDATE }}
  WEBLATE_AUTO_UPDATE: {{ .Values.weblate.WEBLATE_AUTO_UPDATE | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_SERVER_EMAIL }}
  WEBLATE_SERVER_EMAIL: {{ .Values.weblate.general.WEBLATE_SERVER_EMAIL | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_FROM_EMAIL }}
  WEBLATE_DEFAULT_FROM_EMAIL: {{ .Values.weblate.general.WEBLATE_DEFAULT_FROM_EMAIL | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_CONTACT_FORM }}
  WEBLATE_CONTACT_FORM: {{ .Values.weblate.general.WEBLATE_CONTACT_FORM | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ALLOWED_HOSTS }}
  WEBLATE_ALLOWED_HOSTS: {{ .Values.weblate.general.WEBLATE_ALLOWED_HOSTS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_REGISTRATION_OPEN }}
  WEBLATE_REGISTRATION_OPEN: "true"
  {{- else }}
  WEBLATE_REGISTRATION_OPEN: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_REGISTRATION_ALLOW_BACKENDS }}
  WEBLATE_REGISTRATION_ALLOW_BACKENDS: {{ .Values.weblate.general.WEBLATE_REGISTRATION_ALLOW_BACKENDS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ENABLE_HTTPS }}
  WEBLATE_ENABLE_HTTPS: "true"
  {{- else }}
  WEBLATE_ENABLE_HTTPS: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_IP_PROXY_HEADER }}
  WEBLATE_IP_PROXY_HEADER: {{ .Values.weblate.general.WEBLATE_IP_PROXY_HEADER | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_SECURE_PROXY_SSL_HEADER }}
  WEBLATE_SECURE_PROXY_SSL_HEADER: {{ .Values.weblate.general.WEBLATE_SECURE_PROXY_SSL_HEADER | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_REQUIRE_LOGIN }}
  WEBLATE_REQUIRE_LOGIN: "true"
  {{- else }}
  WEBLATE_REQUIRE_LOGIN: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_LOGIN_REQUIRED_URLS_EXCEPTIONS }}
  WEBLATE_LOGIN_REQUIRED_URLS_EXCEPTIONS: {{ .Values.weblate.general.WEBLATE_LOGIN_REQUIRED_URLS_EXCEPTIONS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ADD_LOGIN_REQUIRED_URLS_EXCEPTIONS }}
  WEBLATE_ADD_LOGIN_REQUIRED_URLS_EXCEPTIONS: {{ .Values.weblate.general.WEBLATE_ADD_LOGIN_REQUIRED_URLS_EXCEPTIONS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_REMOVE_LOGIN_REQUIRED_URLS_EXCEPTIONS }}
  WEBLATE_REMOVE_LOGIN_REQUIRED_URLS_EXCEPTIONS: {{ .Values.weblate.general.WEBLATE_REMOVE_LOGIN_REQUIRED_URLS_EXCEPTIONS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_GOOGLE_ANALYTICS_ID }}
  WEBLATE_GOOGLE_ANALYTICS_ID: {{ .Values.weblate.general.WEBLATE_GOOGLE_ANALYTICS_ID | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_GITHUB_USERNAME }}
  WEBLATE_GITHUB_USERNAME: {{ .Values.weblate.general.WEBLATE_GITHUB_USERNAME | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_GITHUB_TOKEN }}
  WEBLATE_GITHUB_TOKEN: {{ .Values.weblate.general.WEBLATE_GITHUB_TOKEN | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_GITLAB_USERNAME }}
  WEBLATE_GITLAB_USERNAME: {{ .Values.weblate.general.WEBLATE_GITLAB_USERNAME | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_GITLAB_TOKEN }}
  WEBLATE_GITLAB_TOKEN: {{ .Values.weblate.general.WEBLATE_GITLAB_TOKEN | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_PAGURE_USERNAME }}
  WEBLATE_PAGURE_USERNAME: {{ .Values.weblate.general.WEBLATE_PAGURE_USERNAME | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_PAGURE_TOKEN }}
  WEBLATE_PAGURE_TOKEN: {{ .Values.weblate.general.WEBLATE_PAGURE_TOKEN | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_SIMPLIFY_LANGUAGES }}
  WEBLATE_SIMPLIFY_LANGUAGES: "true"
  {{- else }}
  WEBLATE_SIMPLIFY_LANGUAGES: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_ACCESS_CONTROL }}
  WEBLATE_DEFAULT_ACCESS_CONTROL: {{ .Values.weblate.general.WEBLATE_DEFAULT_ACCESS_CONTROL | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_RESTRICTED_COMPONENT }}
  WEBLATE_DEFAULT_RESTRICTED_COMPONENT: "true"
  {{- else }}
  WEBLATE_DEFAULT_RESTRICTED_COMPONENT: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_TRANSLATION_PROPAGATION }}
  WEBLATE_DEFAULT_TRANSLATION_PROPAGATION: "true"
  {{- else }}
  WEBLATE_DEFAULT_TRANSLATION_PROPAGATION: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_COMMITER_EMAIL }}
  WEBLATE_DEFAULT_COMMITER_EMAIL: {{ .Values.weblate.general.WEBLATE_DEFAULT_COMMITER_EMAIL | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_COMMITER_NAME }}
  WEBLATE_DEFAULT_COMMITER_NAME: {{ .Values.weblate.general.WEBLATE_DEFAULT_COMMITER_NAME | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_SHARED_TM }}
  WEBLATE_DEFAULT_SHARED_TM: "true"
  {{- else }}
  WEBLATE_DEFAULT_SHARED_TM: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_AKISMET_API_KEY }}
  WEBLATE_AKISMET_API_KEY: {{ .Values.weblate.general.WEBLATE_AKISMET_API_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_GPG_IDENTITY }}
  WEBLATE_GPG_IDENTITY: {{ .Values.weblate.general.WEBLATE_GPG_IDENTITY | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_URL_PREFIX }}
  WEBLATE_URL_PREFIX: {{ .Values.weblate.general.WEBLATE_URL_PREFIX | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_SILENCED_SYSTEM_CHECKS }}
  WEBLATE_SILENCED_SYSTEM_CHECKS: {{ .Values.weblate.general.WEBLATE_SILENCED_SYSTEM_CHECKS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_CSP_SCRIPT_SRC }}
  WEBLATE_CSP_SCRIPT_SRC: {{ .Values.weblate.general.WEBLATE_CSP_SCRIPT_SRC | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_CSP_IMG_SRC }}
  WEBLATE_CSP_IMG_SRC: {{ .Values.weblate.general.WEBLATE_CSP_IMG_SRC | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_CSP_CONNECT_SRC }}
  WEBLATE_CSP_CONNECT_SRC: {{ .Values.weblate.general.WEBLATE_CSP_CONNECT_SRC | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_CSP_STYLE_SRC }}
  WEBLATE_CSP_STYLE_SRC: {{ .Values.weblate.general.WEBLATE_CSP_STYLE_SRC | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_CSP_FONT_SRC }}
  WEBLATE_CSP_FONT_SRC: {{ .Values.weblate.general.WEBLATE_CSP_FONT_SRC | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_LICENSE_FILTER }}
  WEBLATE_LICENSE_FILTER: {{ .Values.weblate.general.WEBLATE_LICENSE_FILTER | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_LICENSE_REQUIRED }}
  WEBLATE_LICENSE_REQUIRED: "true"
  {{- else }}
  WEBLATE_LICENSE_REQUIRED: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_WEBSITE_REQUIRED }}
  WEBLATE_WEBSITE_REQUIRED: "true"
  {{- else }}
  WEBLATE_WEBSITE_REQUIRED: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_HIDE_VERSION }}
  WEBLATE_HIDE_VERSION: "true"
  {{- else }}
  WEBLATE_HIDE_VERSION: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_BASIC_LANGUAGES }}
  WEBLATE_BASIC_LANGUAGES: {{ .Values.weblate.general.WEBLATE_BASIC_LANGUAGES | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEFAULT_AUTO_WATCH }}
  WEBLATE_DEFAULT_AUTO_WATCH: "true"
  {{- else }}
  WEBLATE_DEFAULT_AUTO_WATCH: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_RATELIMIT_ATTEMPTS }}
  WEBLATE_RATELIMIT_ATTEMPTS: {{ .Values.weblate.general.WEBLATE_RATELIMIT_ATTEMPTS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_RATELIMIT_LOCKOUT }}
  WEBLATE_RATELIMIT_LOCKOUT: {{ .Values.weblate.general.WEBLATE_RATELIMIT_LOCKOUT | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_RATELIMIT_WINDOW }}
  WEBLATE_RATELIMIT_WINDOW: {{ .Values.weblate.general.WEBLATE_RATELIMIT_WINDOW | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_ENABLE_AVATARS }}
  WEBLATE_ENABLE_AVATARS: "true"
  {{- else }}
  WEBLATE_ENABLE_AVATARS: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_LIMIT_TRANSLATION_LENGTH_BY_SOURCE_LENGTH }}
  WEBLATE_LIMIT_TRANSLATION_LENGTH_BY_SOURCE_LENGTH: "true"
  {{- else }}
  WEBLATE_LIMIT_TRANSLATION_LENGTH_BY_SOURCE_LENGTH: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_SSH_EXTRA_ARGS }}
  WEBLATE_SSH_EXTRA_ARGS: {{ .Values.weblate.general.WEBLATE_SSH_EXTRA_ARGS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_BORG_EXTRA_ARGS }}
  WEBLATE_BORG_EXTRA_ARGS: {{ .Values.weblate.general.WEBLATE_BORG_EXTRA_ARGS | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DATABASE_BACKUP }}
  WEBLATE_DATABASE_BACKUP: {{ .Values.weblate.general.WEBLATE_DATABASE_BACKUP | quote }}
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_DEBUG }}
  WEBLATE_DEBUG: "true"
  {{- else }}
  WEBLATE_DEBUG: "false"
  {{- end }}
  {{- if .Values.weblate.general.WEBLATE_LOGLEVEL }}
  WEBLATE_LOGLEVEL: {{ .Values.weblate.general.WEBLATE_LOGLEVEL | quote }}
  {{- end }}
  {{/* Machine Translation */}}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_APERTIUM_APY }}
  WEBLATE_MT_APERTIUM_APY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_APERTIUM_APY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_AWS_REGION }}
  WEBLATE_MT_AWS_REGION: {{ .Values.weblate.machinetranslate.WEBLATE_MT_AWS_REGION | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_AWS_ACCESS_KEY_ID }}
  WEBLATE_MT_AWS_ACCESS_KEY_ID: {{ .Values.weblate.machinetranslate.WEBLATE_MT_AWS_ACCESS_KEY_ID | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_AWS_SECRET_ACCESS_KEY }}
  WEBLATE_MT_AWS_SECRET_ACCESS_KEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_AWS_SECRET_ACCESS_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_DEEPL_KEY }}
  WEBLATE_MT_DEEPL_KEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_DEEPL_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_DEEPL_API_URL }}
  WEBLATE_MT_DEEPL_API_URL: {{ .Values.weblate.machinetranslate.WEBLATE_MT_DEEPL_API_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_LIBRETRANSLATE_KEY }}
  WEBLATE_MT_LIBRETRANSLATE_KEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_LIBRETRANSLATE_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_LIBRETRANSLATE_API_URL }}
  WEBLATE_MT_LIBRETRANSLATE_API_URL: {{ .Values.weblate.machinetranslate.WEBLATE_MT_LIBRETRANSLATE_API_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_KEY }}
  WEBLATE_MT_GOOGLE_KEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_CREDENTIALS }}
  WEBLATE_MT_GOOGLE_CREDENTIALS: {{ .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_CREDENTIALS | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_PROJECT }}
  WEBLATE_MT_GOOGLE_PROJECT: {{ .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_PROJECT | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_LOCATION }}
  WEBLATE_MT_GOOGLE_LOCATION: {{ .Values.weblate.machinetranslate.WEBLATE_MT_GOOGLE_LOCATION | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_COGNITIVE_KEY }}
  WEBLATE_MT_MICROSOFT_COGNITIVE_KEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_COGNITIVE_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_ENDPOINT_URL }}
  WEBLATE_MT_MICROSOFT_ENDPOINT_URL: {{ .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_ENDPOINT_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_REGION }}
  WEBLATE_MT_MICROSOFT_REGION: {{ .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_REGION | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_BASE_URL }}
  WEBLATE_MT_MICROSOFT_BASE_URL: {{ .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_BASE_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MODERNMT_KEY }}
  WEBLATE_MT_MODERNMT_KEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_MODERNMT_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MYMEMORY_ENABLED }}
  WEBLATE_MT_MYMEMORY_ENABLED: "true"
  {{- else }}
  WEBLATE_MT_MYMEMORY_ENABLED: "false"
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_GLOSBE_ENABLED }}
  WEBLATE_MT_GLOSBE_ENABLED: "true"
  {{- else }}
  WEBLATE_MT_GLOSBE_ENABLED: "false"
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_MICROSOFT_TERMINOLOGY_ENABLED }}
  WEBLATE_MT_MICROSOFT_TERMINOLOGY_ENABLED: "true"
  {{- else }}
  WEBLATE_MT_MICROSOFT_TERMINOLOGY_ENABLED: "false"
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_SAP_BASE_URL }}
  WEBLATE_MT_SAP_BASE_URL: {{ .Values.weblate.machinetranslate.WEBLATE_MT_SAP_BASE_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_SAP_SANDBOX_APIKEY }}
  WEBLATE_MT_SAP_SANDBOX_APIKEY: {{ .Values.weblate.machinetranslate.WEBLATE_MT_SAP_SANDBOX_APIKEY | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_SAP_USERNAME }}
  WEBLATE_MT_SAP_USERNAME: {{ .Values.weblate.machinetranslate.WEBLATE_MT_SAP_USERNAME | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_SAP_PASSWORD }}
  WEBLATE_MT_SAP_PASSWORD: {{ .Values.weblate.machinetranslate.WEBLATE_MT_SAP_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.weblate.machinetranslate.WEBLATE_MT_SAP_USE_MT }}
  WEBLATE_MT_SAP_USE_MT: "true"
  {{- else }}
  WEBLATE_MT_SAP_USE_MT: "false"
  {{- end }}
  {{/* Authentication */}}
  {{/* LDAP */}}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_SERVER_URI }}
  WEBLATE_AUTH_LDAP_SERVER_URI: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_SERVER_URI | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_DN_TEMPLATE }}
  WEBLATE_AUTH_LDAP_USER_DN_TEMPLATE: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_DN_TEMPLATE | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_ATTR_MAP }}
  WEBLATE_AUTH_LDAP_USER_ATTR_MAP: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_ATTR_MAP | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_BIND_DN }}
  WEBLATE_AUTH_LDAP_BIND_DN: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_BIND_DN | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_BIND_PASSWORD }}
  WEBLATE_AUTH_LDAP_BIND_PASSWORD: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_BIND_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_CONNECTION_OPTION_REFERRALS }}
  WEBLATE_AUTH_LDAP_CONNECTION_OPTION_REFERRALS: "true"
  {{- else }}
  WEBLATE_AUTH_LDAP_CONNECTION_OPTION_REFERRALS: "false"
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH }}
  WEBLATE_AUTH_LDAP_USER_SEARCH: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH_FILTER }}
  WEBLATE_AUTH_LDAP_USER_SEARCH_FILTER: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH_FILTER | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH_UNION }}
  WEBLATE_AUTH_LDAP_USER_SEARCH_UNION: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH_UNION | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH_UNION_DELIMITER }}
  WEBLATE_AUTH_LDAP_USER_SEARCH_UNION_DELIMITER: {{ .Values.weblate.auth.ldap.WEBLATE_AUTH_LDAP_USER_SEARCH_UNION_DELIMITER | quote }}
  {{- end }}
  {{/* Github */}}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_KEY }}
  WEBLATE_SOCIAL_AUTH_GITHUB_KEY: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_SECRET }}
  WEBLATE_SOCIAL_AUTH_GITHUB_SECRET: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_ORG_KEY }}
  WEBLATE_SOCIAL_AUTH_GITHUB_ORG_KEY: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_ORG_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_ORG_SECRET }}
  WEBLATE_SOCIAL_AUTH_GITHUB_ORG_SECRET: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_ORG_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_ORG_NAME }}
  WEBLATE_SOCIAL_AUTH_GITHUB_ORG_NAME: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_ORG_NAME | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_KEY }}
  WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_KEY: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_SECRET }}
  WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_SECRET: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_ID }}
  WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_ID: {{ .Values.weblate.auth.github.WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_ID | quote }}
  {{- end }}
  {{/* Bitbucket */}}
  {{- if .Values.weblate.auth.bitbucket.WEBLATE_SOCIAL_AUTH_BITBUCKET_KEY }}
  WEBLATE_SOCIAL_AUTH_BITBUCKET_KEY: {{ .Values.weblate.auth.bitbucket.WEBLATE_SOCIAL_AUTH_BITBUCKET_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.bitbucket.WEBLATE_SOCIAL_AUTH_BITBUCKET_SECRET }}
  WEBLATE_SOCIAL_AUTH_BITBUCKET_SECRET: {{ .Values.weblate.auth.bitbucket.WEBLATE_SOCIAL_AUTH_BITBUCKET_SECRET | quote }}
  {{- end }}
  {{/* Facebook */}}
  {{- if .Values.weblate.auth.facebook.WEBLATE_SOCIAL_AUTH_FACEBOOK_KEY }}
  WEBLATE_SOCIAL_AUTH_FACEBOOK_KEY: {{ .Values.weblate.auth.facebook.WEBLATE_SOCIAL_AUTH_FACEBOOK_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.facebook.WEBLATE_SOCIAL_AUTH_FACEBOOK_SECRET }}
  WEBLATE_SOCIAL_AUTH_FACEBOOK_SECRET: {{ .Values.weblate.auth.facebook.WEBLATE_SOCIAL_AUTH_FACEBOOK_SECRET | quote }}
  {{- end }}
  {{/* Google */}}
  {{- if .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_KEY }}
  WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_KEY: {{ .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET }}
  WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET: {{ .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_DOMAINS }}
  WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_DOMAINS: {{ .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_DOMAINS | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_EMAILS }}
  WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_EMAILS: {{ .Values.weblate.auth.google.WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_EMAILS | quote }}
  {{- end }}
  {{/* GitLab */}}
  {{- if .Values.weblate.auth.gitlab.WEBLATE_SOCIAL_AUTH_GITLAB_KEY }}
  WEBLATE_SOCIAL_AUTH_GITLAB_KEY: {{ .Values.weblate.auth.gitlab.WEBLATE_SOCIAL_AUTH_GITLAB_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.gitlab.WEBLATE_SOCIAL_AUTH_GITLAB_SECRET }}
  WEBLATE_SOCIAL_AUTH_GITLAB_SECRET: {{ .Values.weblate.auth.gitlab.WEBLATE_SOCIAL_AUTH_GITLAB_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.gitlab.WEBLATE_SOCIAL_AUTH_GITLAB_API_URL }}
  WEBLATE_SOCIAL_AUTH_GITLAB_API_URL: {{ .Values.weblate.auth.gitlab.WEBLATE_SOCIAL_AUTH_GITLAB_API_URL | quote }}
  {{- end }}
  {{/* Azure Active Directory */}}
  {{- if .Values.weblate.auth.azure.WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_KEY }}
  WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_KEY: {{ .Values.weblate.auth.azure.WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.azure.WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_SECRET }}
  WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_SECRET: {{ .Values.weblate.auth.azure.WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_SECRET | quote }}
  {{- end }}
  {{/* Azure Active Directory with Tenant support */}}
  {{- if .Values.weblate.auth.azuretenant.WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_KEY }}
  WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_KEY: {{ .Values.weblate.auth.azuretenant.WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.azuretenant.WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_SECRET }}
  WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_SECRET: {{ .Values.weblate.auth.azuretenant.WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.azuretenant.WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID }}
  WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID: {{ .Values.weblate.auth.azuretenant.WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID | quote }}
  {{- end }}
  {{/* Keycloak */}}
  {{- if .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_KEY }}
  WEBLATE_SOCIAL_AUTH_KEYCLOAK_KEY: {{ .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_SECRET }}
  WEBLATE_SOCIAL_AUTH_KEYCLOAK_SECRET: {{ .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_SECRET | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_PUBLIC_KEY }}
  WEBLATE_SOCIAL_AUTH_KEYCLOAK_PUBLIC_KEY: {{ .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_PUBLIC_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_ALGORITHM }}
  WEBLATE_SOCIAL_AUTH_KEYCLOAK_ALGORITHM: {{ .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_ALGORITHM | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_AUTHORIZATION_URL }}
  WEBLATE_SOCIAL_AUTH_KEYCLOAK_AUTHORIZATION_URL: {{ .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_AUTHORIZATION_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_ACCESS_TOKEN_URL }}
  WEBLATE_SOCIAL_AUTH_KEYCLOAK_ACCESS_TOKEN_URL: {{ .Values.weblate.auth.keycloak.WEBLATE_SOCIAL_AUTH_KEYCLOAK_ACCESS_TOKEN_URL | quote }}
  {{- end }}
  {{/* Linux vendors */}}
  {{- if .Values.weblate.auth.linux.WEBLATE_SOCIAL_AUTH_FEDORA }}
  WEBLATE_SOCIAL_AUTH_FEDORA: "true"
  {{- end }}
  {{- if .Values.weblate.auth.linux.WEBLATE_SOCIAL_AUTH_OPENSUSE }}
  WEBLATE_SOCIAL_AUTH_OPENSUSE: "true"
  {{- end }}
  {{- if .Values.weblate.auth.linux.WEBLATE_SOCIAL_AUTH_UBUNTU }}
  WEBLATE_SOCIAL_AUTH_UBUNTU: "true"
  {{- end }}
  {{/* Slack */}}
  {{- if .Values.weblate.auth.slack.WEBLATE_SOCIAL_AUTH_SLACK_KEY }}
  WEBLATE_SOCIAL_AUTH_SLACK_KEY: {{ .Values.weblate.auth.slack.WEBLATE_SOCIAL_AUTH_SLACK_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.slack.SOCIAL_AUTH_SLACK_SECRET }}
  SOCIAL_AUTH_SLACK_SECRET: {{ .Values.weblate.auth.slack.SOCIAL_AUTH_SLACK_SECRET }}
  {{- end }}
  {{/* SAML */}}
  {{- if .Values.weblate.auth.saml.WEBLATE_SAML_IDP_ENTITY_ID }}
  WEBLATE_SAML_IDP_ENTITY_ID: {{ .Values.weblate.auth.saml.WEBLATE_SAML_IDP_ENTITY_ID | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.saml.WEBLATE_SAML_IDP_URL }}
  WEBLATE_SAML_IDP_URL: {{ .Values.weblate.auth.saml.WEBLATE_SAML_IDP_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.auth.saml.WEBLATE_SAML_IDP_X509CERT }}
  WEBLATE_SAML_IDP_X509CERT: {{ .Values.weblate.auth.saml.WEBLATE_SAML_IDP_X509CERT | quote }}
  {{- end }}
  {{/* Email Server */}}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_HOST }}
  WEBLATE_EMAIL_HOST: {{ .Values.weblate.email.WEBLATE_EMAIL_HOST | quote }}
  {{- end }}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_PORT }}
  WEBLATE_EMAIL_PORT: {{ .Values.weblate.email.WEBLATE_EMAIL_PORT | quote }}
  {{- end }}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_HOST_USER }}
  WEBLATE_EMAIL_HOST_USER: {{ .Values.weblate.email.WEBLATE_EMAIL_HOST_USER | quote }}
  {{- end }}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_HOST_PASSWORD }}
  WEBLATE_EMAIL_HOST_PASSWORD: {{ .Values.weblate.email.WEBLATE_EMAIL_HOST_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_USE_SSL }}
  WEBLATE_EMAIL_USE_SSL: "true"
  {{- else }}
  WEBLATE_EMAIL_USE_SSL: "false"
  {{- end }}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_USE_TLS }}
  WEBLATE_EMAIL_USE_TLS: "true"
  {{- else }}
  WEBLATE_EMAIL_USE_TLS: "false"
  {{- end }}
  {{- if .Values.weblate.email.WEBLATE_EMAIL_BACKEND }}
  WEBLATE_EMAIL_BACKEND: {{ .Values.weblate.email.WEBLATE_EMAIL_BACKEND | quote }}
  {{- end }}
  {{/* Site Integration */}}
  {{- if .Values.weblate.siteintegration.WEBLATE_GET_HELP_URL }}
  WEBLATE_GET_HELP_URL: {{ .Values.weblate.siteintegration.WEBLATE_GET_HELP_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.siteintegration.WEBLATE_STATUS_URL }}
  WEBLATE_STATUS_URL: {{ .Values.weblate.siteintegration.WEBLATE_STATUS_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.siteintegration.WEBLATE_LEGAL_URL }}
  WEBLATE_LEGAL_URL: {{ .Values.weblate.siteintegration.WEBLATE_LEGAL_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.siteintegration.WEBLATE_PRIVACY_URL }}
  WEBLATE_PRIVACY_URL: {{ .Values.weblate.siteintegration.WEBLATE_PRIVACY_URL | quote }}
  {{- end }}
  {{/* Error Reporting */}}
  {{- if .Values.weblate.errorreport.ROLLBAR_KEY }}
  ROLLBAR_KEY: {{ .Values.weblate.REPALCEME.ROLLBAR_KEY | quote }}
  {{- end }}
  {{- if .Values.weblate.errorreport.ROLLBAR_ENVIRONMENT }}
  ROLLBAR_ENVIRONMENT: {{ .Values.weblate.REPALCEME.ROLLBAR_ENVIRONMENT | quote }}
  {{- end }}
  {{- if .Values.weblate.errorreport.SENTRY_DSN }}
  SENTRY_DSN: {{ .Values.weblate.REPALCEME.SENTRY_DSN | quote }}
  {{- end }}
  {{- if .Values.weblate.errorreport.SENTRY_ENVIRONMENT }}
  SENTRY_ENVIRONMENT: {{ .Values.weblate.REPALCEME.SENTRY_ENVIRONMENT | quote }}
  {{- end }}
  {{/* Localization CDN */}}
  {{- if .Values.weblate.localization.WEBLATE_LOCALIZE_CDN_URL }}
  WEBLATE_LOCALIZE_CDN_URL: {{ .Values.weblate.localization.WEBLATE_LOCALIZE_CDN_URL | quote }}
  {{- end }}
  {{- if .Values.weblate.localization.WEBLATE_LOCALIZE_CDN_PATH }}
  WEBLATE_LOCALIZE_CDN_PATH: {{ .Values.weblate.localization.WEBLATE_LOCALIZE_CDN_PATH | quote }}
  {{- end }}
{{- end -}}
