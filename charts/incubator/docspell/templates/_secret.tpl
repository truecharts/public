{{/* Define the secret */}}
{{- define "docspell.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $joexSecretName := printf "%s-joex-secret" (include "tc.common.names.fullname" .) }}
{{- $storeSecretName := printf "%s-store-secret" (include "tc.common.names.fullname" .) }}

{{- $server := .Values.rest_server -}}
{{- $serverID := printf "server-%v" (randAlphaNum 10) -}}

{{- $joex := .Values.joex -}}
{{- $joexID := printf "joex-%v" (randAlphaNum 10) -}}
{{- $tmpDir := "/tmp" -}}

{{- $server_secret := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $storeSecretName) }}
{{- $server_secret = (index .data "server_secret") }}
{{- else }}
{{- $server_secret = printf "b64:%v" (randAlphaNum 32 | b64enc) }}
{{- end }}

{{- $new_invite_password := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $storeSecretName) }}
{{- $new_invite_password = (index .data "new_invite_password") }}
{{- else }}
{{- $new_invite_password = randAlphaNum 32 | b64enc }}
{{- end }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $storeSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  server_secret: {{ $server_secret }}
  new_invite_password: {{ $new_invite_password }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $serverSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  server.conf: |
    # TODO: handle false and 0 vs defaults
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
        max-connections = {{ $server_opts.max_connections }}
        response-timeout = {{ $server_opts.response_timeout | default "45s" }}
      }
      max-item-page-size = {{ $server.max_item_page_size }}
      max-note-length = {{ $server.max_note_length }}
      show-classification-settings = {{ $server.show_classification_settings }}
      {{- $auth := $server.auth }}
      auth {
        server-secret = {{ $server_secret | quote }}
        session-valid = {{ $auth.session_valid | default "5 minutes" | quote }}
        remember-me {
          enabled = {{ $auth.remember_me.enabled }}
          valid = {{ $auth.remember_me.valid | default "30 days" | quote }}
        }
      }
      {{- $download_all := $server.download_all }}
      download-all {
        max-files = {{ $download_all.max_files }}
        max-size = {{ $download_all.max_size | default "1400M" }}
      }
      {{- $openid := $server.openid }}
      openid =
        [
          {{- range initial $openid }}
          {
            enabled = {{ .enabled }},
            display = {{ .display | quote }}
            provider = {
              provider-id = {{ .provider.provider_id | quote }},
              client-id = {{ .provider.client_id | quote }},
              client-secret = {{ .provider.client_secret | quote }},
              scope = {{ .provider.scope | quote }},
              authorize-url = {{ .provider.authorize_url | quote }},
              token-url = {{ .provider.token_url | quote }},
              user-url = {{ .provider.user_url | quote }},
              logout-url = {{ .provider.logout_url | quote }},
              sign-key = {{ .provider.sign_key | quote }},
              sig-algo = {{ .provider.sig_algo | quote }}
            },
            collective-key = {{ .collective_key | quote }},
            user-key = {{ .user_key | quote }}
          },
          {{- end }}
          {{- with last $openid }}
          {
            enabled = {{ .enabled }},
            display = {{ .display | quote }}
            provider = {
              provider-id = {{ .provider.provider_id | quote }},
              client-id = {{ .provider.client_id | quote }},
              client-secret = {{ .provider.client_secret | quote }},
              scope = {{ .provider.scope | quote }},
              authorize-url = {{ .provider.authorize_url | quote }},
              token-url = {{ .provider.token_url | quote }},
              user-url = {{ .provider.user_url | quote }},
              logout-url = {{ .provider.logout_url | quote }},
              sign-key = {{ .provider.sign_key | quote }},
              sig-algo = {{ .provider.sig_algo | quote }}
            },
            collective-key = {{ .collective_key | quote }},
            user-key = {{ .user_key | quote }}
          }
        {{- end }}
        ]
      oidc-auto-redirect = {{ $server.oidc_auto_redirect }}
      {{- $integration_endpoint := $server.integration_endpoint }}
      integration-endpoint {
        enabled = {{ $integration_endpoint.enabled | default false }}
        priority = {{ $integration_endpoint.priority | default "low" | quote }}
        source-name = {{ $integration_endpoint.source_name | default "integration" | quote }}
        allowed-ips {
          enabled = {{ $integration_endpoint.allowed_ips.enabled | default false }}
          ips = [
            {{- range initial $integration_endpoint.allowed_ips.ips }}
            {{ . | quote }},
            {{- end }}
            {{ last $integration_endpoint.allowed_ips.ips | quote }}
          ]
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
      {{- $full_text_search := $server.full_text_search }}
      full-text-search {
        enabled = true
        backend = "solr"
        solr = {
          url = {{ printf "http://%v:%v@%v-solr:8983/%v" .Values.solr.solrUsername (.Values.solr.solrPassword | trimAll "\"") .Release.Name .Values.solr.solrCores | quote }}
          commit-within = {{ $full_text_search.solr.commit_within | default 1000 }}
          log-verbose = {{ $full_text_search.solr.log_verbose | default false }}
          def-type = {{ $full_text_search.solr.def_type | default "lucene" | quote }}
          q-op = {{ $full_text_search.solr.q_op | default "OR" | quote }}
        }
        postgresql = {
          use-default-connection = false
          jdbc {
            url = {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase | quote }}
            user = {{ .Values.postgresql.postgresqlUsername | quote }}
            password = {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | quote }}
          }
          pg-config = {
          }
          pg-query-parser = "websearch_to_tsquery"
          pg-rank-normalization = [ 4 ]
        }
      }
      {{- $backend := $server.backend }}
      backend {
        mail-debug = {{ $backend.mail_debug | default false }}
        jdbc {
          url = {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase | quote }}
          user = {{ .Values.postgresql.postgresqlUsername | quote }}
          password = {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | quote }}
        }
        {{- $database_schema := $server.backend.database_schema }}
        database-schema = {
          run-main-migrations = {{ $database_schema.run_main_migrations }}
          run-fixup-migrations = {{ $database_schema.run_fixup_migrations }}
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
          chunk-size = {{ $files.chunk_size }}
          valid-mime-types = [
            {{- range initial $files.valid_mime_types }}
            {{ . | quote }},
            {{- end }}
            {{ last $files.valid_mime_types | quote }}
          ]
          default-store = {{ $files.default_store | default "database" | quote }}
          stores = {
            database = {
                enabled = {{ $files.stores.database.enabled }}
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
          allow-impure = {{ $addons.allow_impure }}
          allowed-urls = [
            {{- range initial $addons.allowed_urls }}
            {{ . | quote }},
            {{- end }}
            {{ last $addons.allowed_urls | quote }}
          ]
          denied-urls = [
            {{- range initial $addons.denied_urls }}
            {{ . | quote }},
            {{- end }}
            {{ last $addons.denied_urls | quote }}
          ]
        }
      }
    }
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $joexSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  joex.conf: |
    docspell.joex {
      app-id = {{ $joexID | quote }}
      base-url = {{ printf "%v:%v" "http://localhost" .Values.service.joex.ports.joex.port | quote }}
      bind {
        address = "0.0.0.0"
        port = {{ .Values.service.joex.ports.joex.port }}
      }
      {{- $logging := $joex.logging }}
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
      jdbc {
        url = {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase | quote }}
        user = {{ .Values.postgresql.postgresqlUsername | quote }}
        password = {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | quote }}
      }
      {{- $database_schema := $joex.database_schema }}
      database-schema = {
        run-main-migrations = {{ $database_schema.run_main_migrations }}
        run-fixup-migrations = {{ $database_schema.run_fixup_migrations }}
        repair-schema = {{ $database_schema.repair_schema | default false }}
      }
      mail-debug = {{ $joex.mail_debug | default false }}
      send-mail {
        list-id = {{ $joex.send_mail.list_id | default "" | quote }}
      }
      {{- $scheduler := $joex.scheduler }}
      scheduler {
        name = {{ $joexID | quote }}
        pool-size = {{ $scheduler.pool_size }}
        counting-scheme = {{ $joex.counting_scheme | default "4,1" | quote }}
        retries = {{ $scheduler.retries }}
        retry-delay = {{ $scheduler.retry_delay | default "1 minute" | quote }}
        log-buffer-size = {{ $scheduler.log_buffer_size }}
        wakeup-period = {{ $scheduler.wakeup_period | default "30 minutes" | quote }}
      }
      {{- $periodic_scheduler := $joex.periodic_scheduler }}
      periodic-scheduler {
        name = {{ $joexID | quote }}
        wakeup-period = {{ $periodic_scheduler.wakeup_period | default "10 minutes" | quote }}
      }
      {{- $user_tasks := $joex.user_tasks }}
      user-tasks {
        scan-mailbox {
          max-folders = {{ $user_tasks.scan_mailbox.max_folders }}
          mail-chunk-size = {{ $user_tasks.scan_mailbox.mail_chunk_size }}
          max-mails = {{ $user_tasks.scan_mailbox.max_mails }}
        }
      }
      {{- $house_keeping := $joex.house_keeping }}
      house-keeping {
        schedule = {{ $house_keeping.schedule | default "Sun *-*-* 00:00:00 UTC" | quote }}
        cleanup-invites = {
          enabled = {{ $house_keeping.cleanup_invites.enabled }}
          older-than = {{ $house_keeping.cleanup_invites.older_than | default "30 days" | quote }}
        }
        cleanup-remember-me = {
          enabled = {{ $house_keeping.cleanup_remember_me.enabled }}
          older-than = {{ $house_keeping.cleanup_remember_me.older_than | default "30 days" | quote }}
        }
        cleanup-jobs = {
          enabled = {{ $house_keeping.cleanup_jobs.enabled }}
          older-than = {{ $house_keeping.cleanup_jobs.older_than | default "30 days" | quote }}
          delete-batch = {{ $house_keeping.cleanup_jobs.delete_batch | default "100" | quote }}
        }
        cleanup-downloads = {
          enabled = {{ $house_keeping.cleanup_downloads.enabled }}
          older-than = {{ $house_keeping.cleanup_downloads.older_than | default "14 days" | quote }}
        }
        check-nodes {
          enabled = {{ $house_keeping.check_nodes.enabled }}
          min-not-found = {{ $house_keeping.check_nodes.min_not_found }}
        }
        integrity-check {
          enabled = {{ $house_keeping.integrity_check.enabled }}
        }
      }
      update-check {
        enabled = {{ $house_keeping.update_check.enabled | default false }}
        test-run = {{ $house_keeping.update_check.test_run | default false }}
        schedule = {{ $house_keeping.update_check.schedule | default "Sun *-*-* 00:00:00 UTC" | quote }}
        sender-account = {{ $house_keeping.update_check.sender_account | default "" | quote }}
        smtp-id = {{ $house_keeping.update_check.smtp_id | default "" | quote }}
        recipients = [
          {{- range initial $house_keeping.update_check.recipients }}
          {{ . | quote }},
          {{- end }}
          {{ last $house_keeping.update_check.recipients | quote }}
        ]
        subject = {{ $house_keeping.update_check.subject | default "Docspeasdll {{ latestVersion }} is available" | quote }}
        body = {{ $house_keeping.update_check.body | default "You need to define a body!" | quote }}
      }
      {{- $extraction := $joex.extraction }}
      extraction {
        pdf {
          min-text-len = {{ $extraction.pdf.min_text_length }}
        }
        preview {
          dpi = {{ $extraction.preview.dpi }}
        }
        ocr {
          max-image-size = {{ $extraction.ocr.max_image_size }}
          page-range {
            begin = {{ $extraction.ocr.page_range.begin }}
          }
          ghostscript {
            command {
              program = {{ $extraction.ghostscript.command.program | quote }}
              args = [
                {{- range initial $extraction.ghostscript.command.args }}
                {{ . | quote }},
                {{- end }}
                {{ last $extraction.ghostscript.command.args | quote }}
              ]
              timeout = {{ $extraction.ghostscript.command.timeout | default "5 minutes" | quote }}
            }
            working-dir = {{ $extraction.ghostscript.working_dir | quote }}
          }
          unpaper {
            command {
              program = {{ $extraction.unpaper.command.program | quote }}
              args = [
                {{- range initial $extraction.unpaper.command.args }}
                {{ . | quote }},
                {{- end }}
                {{ last $extraction.unpaper.command.args | quote }}
              ]
              timeout = {{ $extraction.unpaper.command.timeout | default "5 minutes" | quote }}
            }
          }
          tesseract {
            command {
              program = {{ $extraction.tesseract.command.program | quote }}
              args = [
                {{- range initial $extraction.tesseract.command.args }}
                {{ . | quote }},
                {{- end }}
                {{ last $extraction.tesseract.command.args | quote }}
              ]
              timeout = {{ $extraction.tesseract.command.timeout | default "5 minutes" | quote }}
            }
          }
        }
      }
      {{- $text_analysis := $joex.text_analysis }}
      text-analysis {
        max-length = {{ $text_analysis.max_length }}
        working-dir = {{ $text_analysis.working_dir | quote }}
        nlp {
          mode = {{ $text_analysis.nlp.mode | default "full" }}
          clear-interval = {{ $text_analysis.nlp.clear_interval | default "15 minutes" | quote }}
          max-due-date-years = {{ $text_analysis.nlp.max_due_date_years }}
          regex-ner {
            max-entries = {{ $text_analysis.nlp.regex_ner.max_entries }}
            file-cache-time = {{ $text_analysis.nlp.regex_ner.file_cache_time }}
          }
        }
        {{- $classification := $joex.classification }}
        classification {
          enabled = {{ $classification.enabled }}
          item-count = {{ $classification.item_count }}
          classifiers = [
            {
              "useSplitWords" = "{{ $classification.classifiers.useSplitWords }}"
              "splitWordsTokenizerRegexp" = {{ $classification.classifiers.splitWordsTokenizerRegexp }}
              "splitWordsIgnoreRegexp" = {{ $classification.classifiers.splitWordsIgnoreRegexp }}
              "useSplitPrefixSuffixNGrams" = "{{ $classification.classifiers.useSplitPrefixSuffixNGrams }}"
              "maxNGramLeng" = "{{ $classification.classifiers.maxNGramLeng }}"
              "minNGramLeng" = "{{ $classification.classifiers.minNGramLeng }}"
              "splitWordShape" = "{{ $classification.classifiers.intern | default "chris4" }}"
              "intern" = "{{ $classification.classifiers.intern }}"
            }
          ]
        }
      }
      {{- $convert := $joex.convert }}
      convert {
        chunk-size = {{ $convert.chunk_size }}
        converted-filename-part = {{ $convert.converted_filename_part }}
        max-image-size = {{ $convert.max_image_size }}
        markdown {
          internal-css = """
            {{ $convert.markdown.internal_css | default "body { padding: 2em 5em; }" | quote }}
          """
        }
        wkhtmlpdf {
          command = {
            program = {{ $convert.wkhtmlpdf.command.program | quote }}
            args = [
              {{- range initial $convert.wkhtmlpdf.command.args }}
              {{ . | quote }},
              {{- end }}
              {{ last $convert.wkhtmlpdf.command.args | quote }}
            ]
            timeout = {{ $convert.wkhtmlpdf.timeout | default "2 minutes" | quote }}
          }
          working-dir = {{ $convert.wkhtmlpdf.working_dir | quote }}
        }
        tesseract = {
          command = {
            program = {{ $convert.tesseract.command.program | quote }}
            args = [
              {{- range initial $convert.tesseract.command.args }}
              {{ . | quote }},
              {{- end }}
              {{ last $convert.tesseract.command.args | quote }}
            ]
            timeout = {{ $convert.tesseract.command.timeout | default "5 minutes" | quote }}
          }
          working-dir = {{ $convert.tesseract.working_dir | quote }}
        }
        unoconv = {
          command = {
            program = {{ $convert.unoconv.command.program | quote }}
            args = [
              {{- range initial $convert.unoconv.command.args }}
              {{ . | quote }},
              {{- end }}
              {{ last $convert.unoconv.command.args | quote }}
            ]
            timeout = {{ $convert.tesseract.command.timeout | default "2 minutes" | quote }}
          }
          working-dir = {{ $convert.unoconv.working_dir | quote }}
        }
        ocrmypdf = {
          enabled = {{ $convert.ocrmypdf.enabled | default true }}
          command = {
            program = {{ $convert.ocrmypdf.command.program | quote }}
            args = [
              {{- range initial $convert.ocrmypdf.command.args }}
              {{ . | quote }},
              {{- end }}
              {{ last $convert.ocrmypdf.command.args | quote }}
            ]
            timeout = {{ $convert.ocrmypdf.command.timeout | default "5 minutes" | quote }}
          }
          working-dir = {{ $convert.ocrmypdf.working_dir | quote }}
        }
        decrypt-pdf = {
          enabled = {{ $convert.decrypt_pdf.enabled }}
          passwords = [
            {{- range initial $convert.decrypt_pdf.passwords }}
            {{ . | quote }},
            {{- end }}
            {{ last $convert.decrypt_pdf.passwords | quote }}
          ]
        }
      }
      {{ $files := $joex.files }}
      files {
        chunk-size = {{ $files.chunk_size }}
        valid-mime-types = [
          {{- range initial $files.valid_mime_types }}
          {{ . | quote }},
          {{- end }}
          {{ last $files.valid_mime_types | quote }}
        ]
        default-store = {{ $files.default_store | default "database" | quote }}
        stores = {
          database = {
              enabled = {{ $files.stores.database.enabled }}
              type = "default-database"
            }
          filesystem = {
              enabled = {{ $files.stores.filesystem.enabled }}
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
      {{- $full_text_search := $joex.full_text_search }}
      full-text-search {
        enabled = true
        backend = "solr"
        solr = {
          url = {{ printf "http://%v:%v@%v-solr:8983/%v" .Values.solr.solrUsername (.Values.solr.solrPassword | trimAll "\"") .Release.Name .Values.solr.solrCores | quote }}
          commit-within = {{ $full_text_search.solr.commit_within | default 1000 }}
          log-verbose = {{ $full_text_search.solr.log_verbose | default false }}
          def-type = {{ $full_text_search.solr.def_type | default "lucene" | quote }}
          q-op = {{ $full_text_search.solr.q_op | default "OR" | quote }}
        }
        postgresql = {
          use-default-connection = false
          jdbc {
            url = {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase | quote }}
            user = {{ .Values.postgresql.postgresqlUsername | quote }}
            password = {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | quote }}
          }
          pg-config = {
          }
          pg-query-parser = "websearch_to_tsquery"
          pg-rank-normalization = [ 4 ]
        }
        migration = {
          index-all-chunk = {{ $full_text_search.migration.index_all_chunk | default 10 }}
        }
      }
      {{- $addons := $joex.addons }}
      addons {
        working-dir = {{ $addons.working_dir }}
        cache-dir = {{ $addons.cache_dir }}
        executor-config {
          runner = {{ $addons.executor_config.runner }}
          nspawn = {
            enabled = false
            sudo-binary = "sudo"
            nspawn-binary = "systemd-nspawn"
            container-wait = "100 millis"
          }
          fail-fast = {{ $addons.executor_config.fail_fast }}
          run-timeout = {{ $addons.executor_config.run_timeout | default "15 minutes" | quote }}
          nix-runner {
            nix-binary = "nix"
            build-timeout = "15 minutes"
          }
          docker-runner {
            docker-binary = "docker"
            build-timeout = "15 minutes"
          }
        }
      }
    }
{{- end -}}
