{{/* Define the secret */}}
{{- define "docspell.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $joexSecretName := printf "%s-joex-secret" (include "tc.common.names.fullname" .) }}

{{- $server := .Values.rest_server -}}
{{- $serverID := printf "server-%v" (randAlphaNum 10) -}}

---

{{- $server_secret := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $serverSecretName) }}
{{- $server_secret = (index .data "server_secret") }}
{{- else }}
{{- $server_secret = printf "b64:%v" (randAlphaNum 32 | b64enc) }}
{{- end }}

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $serverSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  server_secret: {{ $server_secret }}
  server.conf: |
    docspell.server {
      app-name = {{ $server.app_name | defautl "Docspell" | quote }}
      app-id = {{ $serverID | quote }}
      base-url = {{ $server.base_url | default (printf "%v:%v" "http://localhost" .Values.service.main.ports.main.port) | quote }}
      internal-url = "http://localhost:7880"
      logging {
        format = "Fancy"
        minimum-level = "Warn"
        levels = {
          "docspell" = "Info"
          "org.flywaydb" = "Info"
          "binny" = "Info"
          "org.http4s" = "Info"
        }
      }
      bind {
        address = "localhost"
        port = 7880
      }
      server-options {
        enable-http-2 = false
        max-connections = 1024
        response-timeout = 45s
      }
      max-item-page-size = 200
      max-note-length = 180
      show-classification-settings = true
      auth {
        server-secret = ""
        session-valid = "5 minutes"
        remember-me {
          enabled = true
          valid = "30 days"
        }
      }
      download-all {
        max-files = 500
        max-size = 1400M
      }
      openid =
        [ { enabled = false,
            display = "Keycloak"
            provider = {
              provider-id = "keycloak",
              client-id = "docspell",
              client-secret = "example-secret-439e-bf06-911e4cdd56a6",
              scope = "profile", # scope is required for OIDC
              authorize-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/auth",
              token-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/token",
              #User URL is not used when signature key is set.
              #user-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/userinfo",
              logout-url = "http://localhost:8080/auth/realms/home/protocol/openid-connect/logout"
              sign-key = "b64:anVzdC1hLXRlc3Q=",
              sig-algo = "RS512"
            },
            collective-key = "lookup:docspell_collective",
            user-key = "preferred_username"
          },
          { enabled = false,
            display = "Github"
            provider = {
              provider-id = "github",
              client-id = "<your github client id>",
              client-secret = "<your github client secret>",
              scope = "", # scope is not needed for github
              authorize-url = "https://github.com/login/oauth/authorize",
              token-url = "https://github.com/login/oauth/access_token",
              user-url = "https://api.github.com/user",
              sign-key = "" # this must be set empty
              sig-algo = "RS256" #unused but must be set to something
            },
            collective-key = "fixed:demo",
            user-key = "login"
          }
        ]
      oidc-auto-redirect = true
      integration-endpoint {
        enabled = false
        priority = "low"
        source-name = "integration"
        allowed-ips {
          enabled = false
          ips = [ "127.0.0.1" ]
        }
        http-basic {
          enabled = false
          realm = "Docspell Integration"
          user = "docspell-int"
          password = "docspell-int"
        }
        http-header {
          enabled = false
          header-name = "Docspell-Integration"
          header-value = "some-secret"
        }
      }
      admin-endpoint {
        # The secret. If empty, the endpoint is disabled.
        secret = ""
      }
      full-text-search {
        enabled = false
        backend = "solr"
        solr = {
          url = "http://localhost:8983/solr/docspell"
          commit-within = 1000
          log-verbose = false
          def-type = "lucene"
          q-op = "OR"
        }
        postgresql = {
          use-default-connection = false
          jdbc {
            url = "jdbc:postgresql://server:5432/db"
            user = "pguser"
            password = ""
          }
          pg-config = {
          }
          pg-query-parser = "websearch_to_tsquery"
          pg-rank-normalization = [ 4 ]
        }
      }
      backend {
        mail-debug = false
        jdbc {
          url = "jdbc:h2://"${java.io.tmpdir}"/docspell-demo.db;MODE=PostgreSQL;DATABASE_TO_LOWER=TRUE;AUTO_SERVER=TRUE"
          user = "sa"
          password = ""
        }
        database-schema = {
          run-main-migrations = true
          run-fixup-migrations = true
          repair-schema = false
        }
        signup {
          mode = "open"
          new-invite-password = ""
          invite-time = "3 days"
        }
        files {
          chunk-size = 524288
          valid-mime-types = [ ]
          default-store = "database"
          stores = {
            database =
              { enabled = true
                type = "default-database"
              }

            filesystem =
              { enabled = false
                type = "file-system"
                directory = "/some/directory"
              }

            minio =
            { enabled = false
              type = "s3"
              endpoint = "http://localhost:9000"
              access-key = "username"
              secret-key = "password"
              bucket = "docspell"
            }
          }
        }
        addons = {
          enabled = false
          allow-impure = true
          allowed-urls = "*"
          denied-urls = ""
        }
      }
    }
{{- end }}
