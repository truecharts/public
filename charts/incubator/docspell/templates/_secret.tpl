{{/* Define the secret */}}
{{- define "docspell.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $joexSecretName := printf "%s-joex-secret" (include "tc.common.names.fullname" .) }}

{{- $server := .Values.rest_server -}}
{{- $serverID := printf "server-%v" (randAlphaNum 10) -}}

{{- $server_secret := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $serverSecretName) }}
{{- $server_secret = (index .data "server_secret") }}
{{- else }}
{{- $server_secret = printf "b64:%v" (randAlphaNum 32 | b64enc) }}
{{- end }}

{{- $new_invite_password := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $serverSecretName) }}
{{- $new_invite_password = (index .data "new_invite_password") }}
{{- else }}
{{- $new_invite_password = randAlphaNum 32 | b64enc }}
{{- end }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $serverSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  server_secret: {{ $server_secret }}
  new_invite_password: {{ $new_invite_password }}
  server.conf: |
    docspell.server {
      app-name = {{ $server.app_name | default "Docspell" | quote }}
      app-id = {{ $serverID | quote }}
      base-url = {{ $server.base_url | default (printf "%v:%v" "http://localhost" .Values.service.main.ports.main.port) | quote }}
      internal-url = {{ printf "%v:%v" "http://localhost" .Values.service.main.ports.main.port | quote }}
      {{- $logging := $server.logging }}
      logging {
        format = {{ $logging.format | default "Fancy" | quote }}
        minimum-level = {{ $logging.minimum_level | default "Warn" | quote }}
        levels = {
          "docspell" = {{ $logging.levels.docspell | default "Info" | quote }}
          "org.flywaydb" = {{ $logging.levels.flywaydb | default "Info" | quote }}
          "binny" = {{ $logging.levels.binny | default "Info" | quote }}
          "org.http4s" = {{ $logging.levels.http4s | default "Info" | quote }}
        }
      }
      bind {
        address = "0.0.0.0"
        port = {{ .Values.service.main.ports.main.port }}
      }
      {{- $server_opts := $server.server_opts }}
      server-options {
        enable-http-2 = {{ $server_opts.enable_http2 | default false }}
        max-connections = {{ $server_opts.max_connections | default 1024 }}
        response-timeout = {{ $server_opts.response_timeout | default "45s" }}
      }
      max-item-page-size = {{ $server.max_item_page_size | default 200 }}
      max-note-length = {{ $server.max_note_length | default 180 }}
      show-classification-settings = {{ $server.show_classification_settings | default true }}
      {{- $auth := $server.auth }}
      auth {
        server-secret = {{ $server_secret | quote }}
        session-valid = {{ $auth.session_valid | default "5 minutes" | quote }}
        remember-me {
          enabled = {{ $auth.remember_me.enabled | default true }}
          valid = {{ $auth.remember_me.valid | default "30 days" | quote }}
        }
      }
      {{- $download_all := $server.download_all }}
      download-all {
        max-files = {{ $download_all.max_files | default 500 }}
        max-size = {{ $download_all.max_size | default "1400M" }}
      }
      # openid =
      #   [ { enabled = false,
      #       display = "Keycloak"
      #       provider = {
      #         provider-id = "keycloak",
      #         client-id = "docspell",
      #         client-secret = "example-secret-439e-bf06-911e4cdd56a6",
      #         scope = "profile", # scope is required for OIDC
      #         authorize-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/auth",
      #         token-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/token",
      #         #User URL is not used when signature key is set.
      #         #user-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/userinfo",
      #         logout-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/logout"
      #         sign-key = "b64:anVzdC1hLXRlc3Q=",
      #         sig-algo = "RS512"
      #       },
      #       collective-key = "lookup:docspell_collective",
      #       user-key = "preferred_username"
      #     },
      #     { enabled = false,
      #       display = "Github"
      #       provider = {
      #         provider-id = "github",
      #         client-id = "<your github client id>",
      #         client-secret = "<your github client secret>",
      #         scope = "", # scope is not needed for github
      #         authorize-url = "https://github.com/login/oauth/authorize",
      #         token-url = "https://github.com/login/oauth/access_token",
      #         user-url = "https://api.github.com/user",
      #         sign-key = "" # this must be set empty
      #         sig-algo = "RS256" #unused but must be set to something
      #       },
      #       collective-key = "fixed:demo",
      #       user-key = "login"
      #     }
      #   ]
      oidc-auto-redirect = {{ $server.oidc_auto_redirect | default true }}
      {{- $integration_endpoint := $server.integration_endpoint }}
      integration-endpoint {
        enabled = {{ $integration_endpoint.enabled | default false }}
        priority = {{ $integration_endpoint.priority | default "low" | quote }}
        source-name = {{ $integration_endpoint.source_name | default "integration" | quote }}
        allowed-ips {
          enabled = {{ $integration_endpoint.allowed_ips.enabled | default false }}
          # TODO:
          ips = [ "127.0.0.1" ]
        }
        http-basic {
          enabled = {{ $integration_endpoint.http_basic_auth.enabled | default false }}
          realm = {{ $integration_endpoint.http_basic_auth.realm | default "Docspell Integration" | quote }}
          user = {{ $integration_endpoint.http_basic_auth.user | default "docspell-int" | quote }}
          password = {{ $integration_endpoint.http_basic_auth.password | default "docspell-int" | quote }}
        }
        http-header {
          enabled = {{ $integration_endpoint.http_header.enabled | default false }}
          header-name = {{ $integration_endpoint.http_header.header_name | default "Docspell-Integration" | quote }}
          header-value = {{ $integration_endpoint.http_header.header_value | default "some-secret" | quote }}
        }
      }
      admin-endpoint {
        secret = {{ $server.admin_endpoint.secret | default "" | quote }}
      }
      # full-text-search {
      #   enabled = false
      #   backend = "solr"
      #   solr = {
      #     url = "http://localhost:8983/solr/docspell"
      #     commit-within = 1000
      #     log-verbose = false
      #     def-type = "lucene"
      #     q-op = "OR"
      #   }
      #   postgresql = {
      #     use-default-connection = false
      #     jdbc {
      #       url = "jdbc:postgresql://server:5432/db"
      #       user = "pguser"
      #       password = ""
      #     }
      #     pg-config = {
      #     }
      #     pg-query-parser = "websearch_to_tsquery"
      #     pg-rank-normalization = [ 4 ]
      #   }
      # }
      {{- $backend := $server.backend }}
      backend {
        mail-debug = {{ $backend.mail_debug | default false }}
        jdbc {
          url = {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase | quote }}
          user = {{ .Values.postgresql.postgresqlUsername | quote }}
          password = {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | quote }}
        }
        {{- $database_schema := $server.database_schema }}
        database-schema = {
          run-main-migrations = {{ $database_schema.run_main_migrations | default true }}
          run-fixup-migrations = {{ $database_schema.run_fixup_migrations | default true }}
          repair-schema = {{ $database_schema.repair_schema | default false }}
        }
        {{- $signup := $server.signup }}
        signup {
          mode = {{ $signup.mode | default "open" | quote }}
          new-invite-password = {{ $new_invite_password | quote }}
          invite-time = {{ $signup.invite_time | default "3 days" | quote }}
        }

        {{- $files := $server.backend.files }}
        files {
          chunk-size = {{ $files.chunk_size | default 524288 }}
          # TODO:
          valid-mime-types = [ ]
          default-store = {{ $files.default_store | default "database" | quote }}
          stores = {
            database = {
                enabled = {{ $files.stores.database.enabled | default true }}
                type = "default-database"
              }
            filesystem = {
                enabled = {{ $files.stores.filesystem.enabled | default false }}
                type = "file-system"
                directory = {{ $files.stores.filesystem.directory | default "/documents" | quote }}
              }
            minio = {
              enabled = {{ $files.stores.minio.enabled | default false }}
              type = "s3"
              endpoint = {{ $files.stores.minio.endpoint | default "http://localhost:9000" | quote }}
              access-key = {{ $files.stores.minio.access_key | default "username" | quote }}
              secret-key = {{ $files.stores.minio.secret_key | default "password" | quote }}
              bucket = {{ $files.stores.minio.bucket | default "docspell" | quote }}
            }
          }
        }
        {{- $addons := $server.addons }}
        addons = {
          enabled = {{ $addons.enabled | default false }}
          allow-impure = {{ $addons.allow_impure | default true }}
          # TODO:
          allowed-urls = "*"
          # TODO:
          denied-urls = ""
        }
      }
    }
{{- end -}}
