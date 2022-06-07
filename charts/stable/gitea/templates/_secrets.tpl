{{/* Define the secrets */}}
{{- define "gitea.secrets" -}}

---

{{ $DOMAIN := ( printf "%s-gitea.%s.svc.%s" .Release.Name .Release.Namespace "cluster.local" | quote ) -}}
{{- if and ( .Values.ingress.main.enabled ) ( gt (len .Values.ingress.main.hosts) 0 ) -}}
{{- $DOMAIN = (index .Values.ingress.main.hosts 0).host -}}
{{- end -}}

apiVersion: v1
kind: Secret
metadata:
  name: {{ include "tc.common.names.fullname" . }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
type: Opaque
stringData:
  app.ini: |-
    APP_NAME = {{ .Values.config.APP_NAME }}
    RUN_MODE = {{ .Values.config.RUN_MODE }}

    [cache]
    ADAPTER = memcache
    ENABLED = true
    HOST = {{ printf "%v-%v:%v" .Release.Name "memcached" "11211" }}
    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if eq $catvalue.name "cache" }}
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}

    [database]
    DB_TYPE = postgres
    HOST = {{ printf "%v-%v:%v" .Release.Name "postgresql" "5432" }}
    NAME = {{ .Values.postgresql.postgresqlDatabase }}
    PASSWD = {{ .Values.postgresql.postgresqlPassword }}
    USER = {{ .Values.postgresql.postgresqlUsername }}
    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if eq $catvalue.name "database" }}
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}

    [metrics]
    ENABLED = {{ .Values.metrics.enabled }}
    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if eq $catvalue.name "metrics" }}
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}

    [repository]
    ROOT = /data/git/gitea-repositories
    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if eq $catvalue.name "repository" }}
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}


    [security]
    INSTALL_LOCK = true
    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if eq $catvalue.name "security" }}
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}

    [server]
    APP_DATA_PATH = /data
    DOMAIN = {{ $DOMAIN }}
    ENABLE_PPROF = false
    HTTP_PORT = {{ .Values.service.main.ports.main.targetPort }}
    PROTOCOL = http
    {{- if and ( .Values.ingress.main.enabled ) ( gt (len .Values.ingress.main.hosts) 0 ) }}
    ROOT_URL = {{ printf "https://%s" $DOMAIN }}
    {{- else }}
    ROOT_URL = {{ printf "http://%s" $DOMAIN }}
    {{- end }}
    SSH_DOMAIN = {{ $DOMAIN }}
    SSH_LISTEN_PORT = {{ .Values.service.ssh.ports.ssh.targetPort }}
    SSH_PORT = {{ .Values.service.ssh.ports.ssh.port }}
    START_SSH_SERVER = true
    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if eq $catvalue.name "server" }}
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}

    {{- range $catindex, $catvalue := .Values.customConfig }}
    {{- if not ( or ( eq $catvalue.name "server" ) ( eq $catvalue.name "server" ) ( eq $catvalue.name "security" ) ( eq $catvalue.name "repository" ) ( eq $catvalue.name "metrics" ) ( eq $catvalue.name "database" ) ( eq $catvalue.name "cache" ) ) }}
    [{{ $catvalue.name }}]
    {{- range $index, $value := $catvalue.keys }}
    {{ $value.name }} = {{ $value.value }}
    {{- end }}
    {{- end }}
    {{- end }}

---

apiVersion: v1
kind: Secret
metadata:
  name: {{ include "tc.common.names.fullname" . }}-init
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
type: Opaque
stringData:
  init_directory_structure.sh: |-
    #!/usr/bin/env bash

    set -euo pipefail

    {{- if .Values.initPreScript }}
    # BEGIN: initPreScript
    {{- with .Values.initPreScript -}}
    {{ . | nindent 4}}
    {{- end -}}
    # END: initPreScript
    {{- end }}

    set -x

    mkdir -p /data/git/.ssh
    chmod -R 700 /data/git/.ssh
    [ ! -d /data/gitea ] && mkdir -p /data/gitea/conf

    # prepare temp directory structure
    mkdir -p "${GITEA_TEMP}"
    chown -Rf {{ .Values.podSecurityContext.runAsUser }}:{{ .Values.podSecurityContext.fsGroup }} "${GITEA_TEMP}"
    chmod ug+rwx "${GITEA_TEMP}"

    # Copy config file to writable volume
    cp /etc/gitea/conf/app.ini /data/gitea/conf/app.ini
    chown -Rf {{ .Values.podSecurityContext.runAsUser }}:{{ .Values.podSecurityContext.fsGroup }}  "/data"
    chmod a+rwx /data/gitea/conf/app.ini

    # Patch dockercontainer for dynamic users
    chown -Rf {{ .Values.podSecurityContext.runAsUser }}:{{ .Values.podSecurityContext.fsGroup }}  "/var/lib/gitea"

  configure_gitea.sh: |-
    #!/usr/bin/env bash

    set -euo pipefail


    # Connection retry inspired by https://gist.github.com/dublx/e99ea94858c07d2ca6de
    function test_db_connection() {
      local RETRY=0
      local MAX=30

      echo 'Wait for database to become avialable...'
      until [ "${RETRY}" -ge "${MAX}" ]; do
        nc -vz -w2 {{ printf "%v-%v" .Release.Name "postgresql" }} 5432 && break
        RETRY=$[${RETRY}+1]
        echo "...not ready yet (${RETRY}/${MAX})"
      done

      if [ "${RETRY}" -ge "${MAX}" ]; then
        echo "Database not reachable after '${MAX}' attempts!"
        exit 1
      fi
    }

    test_db_connection


    echo '==== BEGIN GITEA MIGRATION ===='

    gitea migrate

    echo '==== BEGIN GITEA CONFIGURATION ===='

    {{- if or .Values.admin.existingSecret (and .Values.admin.username .Values.admin.password) }}
    function configure_admin_user() {
      local ACCOUNT_ID=$(gitea admin user list --admin | grep -e "\s\+${GITEA_ADMIN_USERNAME}\s\+" | awk -F " " "{printf \$1}")
      if [[ -z "${ACCOUNT_ID}" ]]; then
        echo "No admin user '${GITEA_ADMIN_USERNAME}' found. Creating now..."
        gitea admin user create --admin --username "${GITEA_ADMIN_USERNAME}" --password "${GITEA_ADMIN_PASSWORD}" --email {{ .Values.admin.email | quote }} --must-change-password=false
        echo '...created.'
      else
        echo "Admin account '${GITEA_ADMIN_USERNAME}' already exist. Running update to sync password..."
        gitea admin user change-password --username "${GITEA_ADMIN_USERNAME}" --password "${GITEA_ADMIN_PASSWORD}"
        echo '...password sync done.'
      fi
    }

    configure_admin_user
    {{- end }}

    {{- if .Values.ldap.enabled }}
    function configure_ldap() {
      local LDAP_NAME={{ (printf "%s" .Values.ldap.name) | squote }}
      local GITEA_AUTH_ID=$(gitea admin auth list --vertical-bars | grep -E "\|${LDAP_NAME}\s+\|" | grep -iE '\|LDAP \(via BindDN\)\s+\|' | awk -F " "  "{print \$1}")

      if [[ -z "${GITEA_AUTH_ID}" ]]; then
        echo "No ldap configuration found with name '${LDAP_NAME}'. Installing it now..."
        gitea admin auth add-ldap {{- include "gitea.ldap_settings" . | indent 1 }}
        echo '...installed.'
      else
        echo "Existing ldap configuration with name '${LDAP_NAME}': '${GITEA_AUTH_ID}'. Running update to sync settings..."
        gitea admin auth update-ldap --id "${GITEA_AUTH_ID}" {{- include "gitea.ldap_settings" . | indent 1 }}
        echo '...sync settings done.'
      fi
    }

    configure_ldap
    {{- end }}

    {{- if .Values.oauth.enabled }}
    function configure_oauth() {
      local OAUTH_NAME={{ (printf "%s" .Values.oauth.name) | squote }}
      local AUTH_ID=$(gitea admin auth list --vertical-bars | grep -E "\|${OAUTH_NAME}\s+\|" | grep -iE '\|OAuth2\s+\|' | awk -F " "  "{print \$1}")

      if [[ -z "${AUTH_ID}" ]]; then
        echo "No oauth configuration found with name '${OAUTH_NAME}'. Installing it now..."
        gitea admin auth add-oauth {{- include "gitea.oauth_settings" . | indent 1 }}
        echo '...installed.'
      else
        echo "Existing oauth configuration with name '${OAUTH_NAME}': '${AUTH_ID}'. Running update to sync settings..."
        gitea admin auth update-oauth --id "${AUTH_ID}" {{- include "gitea.oauth_settings" . | indent 1 }}
        echo '...sync settings done.'
      fi
    }

    configure_oauth
    {{- end }}

    echo '==== END GITEA CONFIGURATION ===='


{{- end -}}
