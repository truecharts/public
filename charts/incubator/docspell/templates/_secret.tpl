{{/* Define the secret */}}
{{- define "docspell.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $joexSecretName := printf "%s-joex-secret" (include "tc.common.names.fullname" .) }}
{{- $storeSecretName := printf "%s-store-secret" (include "tc.common.names.fullname" .) }}

{{- $server := .Values.rest_server -}}
{{- $serverID := printf "server-%v" (randAlphaNum 10) -}}

{{- $joex := .Values.joex -}}
{{- $joexID := printf "joex-%v" (randAlphaNum 10) -}}

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
# TODO: "default" in booleans takes evaluates false as undefined. So when false it will always use the default
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
        run-main-migrations = {{ $database_schema.run_main_migrations | default true }}
        run-fixup-migrations = {{ $database_schema.run_fixup_migrations | default true }}
        repair-schema = {{ $database_schema.repair_schema | default false }}
      }
      mail-debug = {{ $joex.mail_debug | default false }}
      send-mail {
        list-id = {{ $joex.send_mail.list_id | default "" | quote }}
      }
      {{- $scheduler := $joex.scheduler }}
      scheduler {
        name = {{ $joexID | quote }}
        pool-size = {{ $scheduler.pool_size | default 1 }}
        counting-scheme = {{ $joex.counting_scheme | default "4,1" | quote }}
        retries = {{ $scheduler.retries | default 2 }}
        retry-delay = {{ $scheduler.retry_delay | default "1 minute" | quote }}
        log-buffer-size = {{ $scheduler.log_buffer_size | default 500 }}
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
          max-folders = {{ $user_tasks.max_folders | default 50 }}
          mail-chunk-size = {{ $user_tasks.mail_chunk_size | default 50 }}
          max-mails = {{ $user_tasks.max_mails | default 500 }}
        }
      }
      {{- $house_keeping := $joex.house_keeping }}
      house-keeping {
        schedule = {{ $house_keeping.schedule | default "Sun *-*-* 00:00:00 UTC" | quote }}
        cleanup-invites = {
          enabled = {{ $house_keeping.cleanup_invites.enabled | default true }}
          older-than = {{ $house_keeping.cleanup_invites.older_than | default "30 days" | quote }}
        }
        cleanup-remember-me = {
          enabled = {{ $house_keeping.cleanup_remember_me.enabled | default true }}
          older-than = {{ $house_keeping.cleanup_remember_me.older_than | default "30 days" | quote }}
        }
        cleanup-jobs = {
          enabled = {{ $house_keeping.cleanup_jobs.enabled | default true }}
          older-than = {{ $house_keeping.cleanup_jobs.older_than | default "30 days" | quote }}
          delete-batch = {{ $house_keeping.cleanup_jobs.delete_batch | default "100" | quote }}
        }
        cleanup-downloads = {
          enabled = {{ $house_keeping.cleanup_downloads.enabled | default true }}
          older-than = {{ $house_keeping.cleanup_downloads.older_than | default "14 days" | quote }}
        }
        check-nodes {
          enabled = {{ $house_keeping.check_nodes.enabled | default true }}
          min-not-found = {{ $house_keeping.check_nodes.min_not_found | default 2 }}
        }
        integrity-check {
          enabled = {{ $house_keeping.integrity_check.enabled | default true }}
        }
      }
      update-check {
        enabled = {{ $house_keeping.update_check.enabled | default false }}
        test-run = {{ $house_keeping.update_check.test_run | default false }}
        schedule = {{ $house_keeping.update_check.schedule | default "Sun *-*-* 00:00:00 UTC" | quote }}
        sender-account = {{ $house_keeping.update_check.sender_account | default "" | quote }}
        smtp-id = {{ $house_keeping.update_check.smtp_id | default "" | quote }}
        # TODO:
        recipients = []
        subject = {{ $house_keeping.update_check.subject | default "Docspeasdll {{ latestVersion }} is available" | quote }}
        body = {{ $house_keeping.update_check.body | default "You need to define a body!" | quote }}
      }
      {{- $extraction := $joex.extraction }}
      extraction {
        pdf {
          min-text-len = {{ $extraction.pdf.min_text_length | default 500 }}
        }
        preview {
          dpi = {{ $extraction.preview.dpi | default 32 }}
        }
        ocr {
          max-image-size = {{ $extraction.ocr.max_image_size | default 14000000 }}
          page-range {
            begin = {{ $extraction.ocr.page_range.begin | default 10 }}
          }
          # ghostscript {
          #   command {
          #     program = "gs"
          #     args = [ "-dNOPAUSE"
          #           , "-dBATCH"
          #           , "-dSAFER"
          #           , "-sDEVICE=tiffscaled8"
          #           , "-sOutputFile=\{\{outfile\}\}"
          #           , "\{\{infile\}\}"
          #           ]
          #     timeout = "5 minutes"
          #   }
          #   working-dir = ${java.io.tmpdir}"/docspell-extraction"
          # }
          # unpaper {
          #   command {
          #     program = "unpaper"
          #     args = [ "\{\{infile\}\}", "\{\{outfile\}\}" ]
          #     timeout = "5 minutes"
          #   }
          # }
          # tesseract {
          #   command {
          #     program = "tesseract"
          #     args = ["\{\{file\}\}"
          #           , "stdout"
          #           , "-l"
          #           , "\{\{lang\}\}"
          #           ]
          #     timeout = "5 minutes"
          #   }
          # }
        }
      }
      text-analysis {
        # Maximum length of text to be analysed.
        #
        # All text to analyse must fit into RAM. A large document may take
        # too much heap. Also, most important information is at the
        # beginning of a document, so in most cases the first two pages
        # should suffice. Default is 5000, which are about 2 pages (just a
        # rough guess, of course). For my data, more than 80% of the
        # documents are less than 5000 characters.
        #
        # This values applies to nlp and the classifier. If this value is
        # <= 0, the limit is disabled.
        max-length = 5000

        # A working directory for the analyser to store temporary/working
        # files.
        working-dir = ${java.io.tmpdir}"/docspell-analysis"

        nlp {
          # The mode for configuring NLP models:
          #
          # 1. full – builds the complete pipeline
          # 2. basic - builds only the ner annotator
          # 3. regexonly - matches each entry in your address book via regexps
          # 4. disabled - doesn't use any stanford-nlp feature
          #
          # The full and basic variants rely on pre-build language models
          # that are available for only a few languages. Memory usage
          # varies among the languages. So joex should run with -Xmx1400M
          # at least when using mode=full.
          #
          # The basic variant does a quite good job for German and
          # English. It might be worse for French, always depending on the
          # type of text that is analysed. Joex should run with about 500M
          # heap, here again lanugage German uses the most.
          #
          # The regexonly variant doesn't depend on a language. It roughly
          # works by converting all entries in your addressbook into
          # regexps and matches each one against the text. This can get
          # memory intensive, too, when the addressbook grows large. This
          # is included in the full and basic by default, but can be used
          # independently by setting mode=regexner.
          #
          # When mode=disabled, then the whole nlp pipeline is disabled,
          # and you won't get any suggestions. Only what the classifier
          # returns (if enabled).
          mode = full

          # The StanfordCoreNLP library caches language models which
          # requires quite some amount of memory. Setting this interval to a
          # positive duration, the cache is cleared after this amount of
          # idle time. Set it to 0 to disable it if you have enough memory,
          # processing will be faster.
          #
          # This has only any effect, if mode != disabled.
          clear-interval = "15 minutes"

          # Restricts proposals for due dates. Only dates earlier than this
          # number of years in the future are considered.
          max-due-date-years = 10

          regex-ner {
            # Whether to enable custom NER annotation. This uses the
            # address book of a collective as input for NER tagging (to
            # automatically find correspondent and concerned entities). If
            # the address book is large, this can be quite memory
            # intensive and also makes text analysis much slower. But it
            # improves accuracy and can be used independent of the
            # lanugage. If this is set to 0, it is effectively disabled
            # and NER tagging uses only statistical models (that also work
            # quite well, but are restricted to the languages mentioned
            # above).
            #
            # Note, this is only relevant if nlp-config.mode is not
            # "disabled".
            max-entries = 1000

            # The NER annotation uses a file of patterns that is derived
            # from a collective's address book. This is is the time how
            # long this data will be kept until a check for a state change
            # is done.
            file-cache-time = "1 minute"
          }
        }

        # Settings for doing document classification.
        #
        # This works by learning from existing documents. This requires a
        # satstical model that is computed from all existing documents.
        # This process is run periodically as configured by the
        # collective. It may require more memory, depending on the amount
        # of data.
        #
        # It utilises this NLP library: https://nlp.stanford.edu/.
        classification {
          # Whether to enable classification globally. Each collective can
          # enable/disable auto-tagging. The classifier is also used for
          # finding correspondents and concerned entities, if enabled
          # here.
          enabled = true

          # If concerned with memory consumption, this restricts the
          # number of items to consider. More are better for training. A
          # negative value or zero means to train on all items.
          #
          # This limit and `text-analysis.max-length` define how much
          # memory is required. On weaker hardware, it is advised to play
          # with these values.
          item-count = 600

          # These settings are used to configure the classifier. If
          # multiple are given, they are all tried and the "best" is
          # chosen at the end. See
          # https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/classify/ColumnDataClassifier.html
          # for more info about these settings. The settings here yielded
          # good results with *my* dataset.
          #
          # Enclose regexps in triple quotes.
          classifiers = [
            { "useSplitWords" = "true"
              "splitWordsTokenizerRegexp" = """[\p{L}][\p{L}0-9]*|(?:\$ ?)?[0-9]+(?:\.[0-9]{2})?%?|\s+|."""
              "splitWordsIgnoreRegexp" = """\s+"""
              "useSplitPrefixSuffixNGrams" = "true"
              "maxNGramLeng" = "4"
              "minNGramLeng" = "1"
              "splitWordShape" = "chris4"
              "intern" = "true" # makes it slower but saves memory
            }
          ]
        }
      }

      # Configuration for converting files into PDFs.
      #
      # Most of it is delegated to external tools, which can be configured
      # below. They must be in the PATH environment or specify the full
      # path below via the `program` key.
      convert {

        # The chunk size used when storing files. This should be the same
        # as used with the rest server.
        chunk-size = ${docspell.joex.files.chunk-size}

        # A string used to change the filename of the converted pdf file.
        # If empty, the original file name is used for the pdf file ( the
        # extension is always replaced with `pdf`).
        converted-filename-part = "converted"

        # When reading images, this is the maximum size. Images that are
        # larger are not processed.
        max-image-size = ${docspell.joex.extraction.ocr.max-image-size}

        # Settings when processing markdown files (and other text files)
        # to HTML.
        #
        # In order to support text formats, text files are first converted
        # to HTML using a markdown processor. The resulting HTML is then
        # converted to a PDF file.
        markdown {

          # The CSS that is used to style the resulting HTML.
          internal-css = """
            body { padding: 2em 5em; }
          """
        }

        # To convert HTML files into PDF files, the external tool
        # wkhtmltopdf is used.
        wkhtmlpdf {
          command = {
            program = "wkhtmltopdf"
            args = [
              "-s",
              "A4",
              "--encoding",
              "\{\{encoding\}\}",
              "--load-error-handling", "ignore",
              "--load-media-error-handling", "ignore",
              "-",
              "\{\{outfile\}\}"
            ]
            timeout = "2 minutes"
          }
          working-dir = ${java.io.tmpdir}"/docspell-convert"
        }

        # To convert image files to PDF files, tesseract is used. This
        # also extracts the text in one go.
        tesseract = {
          command = {
            program = "tesseract"
            args = [
              "\{\{infile\}\}",
              "out",
              "-l",
              "\{\{lang\}\}",
              "pdf",
              "txt"
            ]
            timeout = "5 minutes"
          }
          working-dir = ${java.io.tmpdir}"/docspell-convert"
        }

        # To convert "office" files to PDF files, the external tool
        # unoconv is used. Unoconv uses libreoffice/openoffice for
        # converting. So it supports all formats that are possible to read
        # with libreoffice/openoffic.
        #
        # Note: to greatly improve performance, it is recommended to start
        # a libreoffice listener by running `unoconv -l` in a separate
        # process.
        unoconv = {
          command = {
            program = "unoconv"
            args = [
              "-f",
              "pdf",
              "-o",
              "\{\{outfile\}\}",
              "\{\{infile\}\}"
            ]
            timeout = "2 minutes"
          }
          working-dir = ${java.io.tmpdir}"/docspell-convert"
        }

        # The tool ocrmypdf can be used to convert pdf files to pdf files
        # in order to add extracted text as a separate layer. This makes
        # image-only pdfs searchable and you can select and copy/paste the
        # text. It also converts pdfs into pdf/a type pdfs, which are best
        # suited for archiving. So it makes sense to use this even for
        # text-only pdfs.
        #
        # It is recommended to install ocrympdf, but it also is optional.
        # If it is enabled but fails, the error is not fatal and the
        # processing will continue using the original pdf for extracting
        # text. You can also disable it to remove the errors from the
        # processing logs.
        #
        # The `--skip-text` option is necessary to not fail on "text" pdfs
        # (where ocr is not necessary). In this case, the pdf will be
        # converted to PDF/A.
        ocrmypdf = {
          enabled = true
          command = {
            program = "ocrmypdf"
            args = [
              "-l", "\{\{lang\}\}",
              "--skip-text",
              "--deskew",
              "-j", "1",
              "\{\{infile\}\}",
              "\{\{outfile\}\}"
            ]
            timeout = "5 minutes"
          }
          working-dir = ${java.io.tmpdir}"/docspell-convert"
        }

        # Allows to try to decrypt a PDF with encryption or protection. If
        # enabled, a PDFs encryption or protection will be removed during
        # conversion.
        #
        # For encrypted PDFs, this is necessary to be processed, because
        # docspell needs to read it. It also requires to specify a
        # password here. All passwords are tried when reading a PDF.
        #
        # This is enabled by default with an empty password list. This
        # removes protection from PDFs, which is better for processing.
        #
        # Passwords can be given here and each collective can maintain
        # their passwords as well. But if the `enabled` setting below is
        # `false`, then no attempt at decrypting is done.
        decrypt-pdf = {
          enabled = true
          passwords = []
        }
      }

      # The same section is also present in the rest-server config. It is
      # used when submitting files into the job queue for processing.
      #
      # Currently, these settings may affect memory usage of all nodes, so
      # it should be the same on all nodes.
      files {
        # Defines the chunk size (in bytes) used to store the files.
        # This will affect the memory footprint when uploading and
        # downloading files. At most this amount is loaded into RAM for
        # down- and uploading.
        #
        # It also defines the chunk size used for the blobs inside the
        # database.
        chunk-size = 524288

        # The file content types that are considered valid. Docspell
        # will only pass these files to processing. The processing code
        # itself has also checks for which files are supported and which
        # not. This affects the uploading part and can be used to
        # restrict file types that should be handed over to processing.
        # By default all files are allowed.
        valid-mime-types = [ ]

        # The id of an enabled store from the `stores` array that should
        # be used.
        #
        # IMPORTANT NOTE: All nodes must have the exact same file store
        # configuration!
        default-store = "database"

        # A list of possible file stores. Each entry must have a unique
        # id. The `type` is one of: default-database, filesystem, s3.
        #
        # The enabled property serves currently to define target stores
        # for te "copy files" task. All stores with enabled=false are
        # removed from the list. The `default-store` must be enabled.
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

      # Configuration of the full-text search engine. (the same must be used for restserver)
      full-text-search {
        # The full-text search feature can be disabled. It requires an
        # additional index server which needs additional memory and disk
        # space. It can be enabled later any time.
        #
        # Currently the SOLR search platform and PostgreSQL is supported.
        enabled = false

        # Which backend to use, either solr or postgresql
        backend = "solr"

        # Configuration for the SOLR backend.
        solr = {
          # The URL to solr
          url = "http://localhost:8983/solr/docspell"
          # Used to tell solr when to commit the data
          commit-within = 1000
          # If true, logs request and response bodies
          log-verbose = false
          # The defType parameter to lucene that defines the parser to
          # use. You might want to try "edismax" or look here:
          # https://solr.apache.org/guide/8_4/query-syntax-and-parsing.html#query-syntax-and-parsing
          def-type = "lucene"
          # The default combiner for tokens. One of {AND, OR}.
          q-op = "OR"
        }

        # Configuration for PostgreSQL backend
        postgresql = {
          # Whether to use the default database, only works if it is
          # postgresql
          use-default-connection = false

          # The database connection.
          jdbc {
            url = "jdbc:postgresql://server:5432/db"
            user = "pguser"
            password = ""
          }

          # A mapping from a language to a postgres text search config. By
          # default a language is mapped to a predefined config.
          # PostgreSQL has predefined configs for some languages. This
          # setting allows to create a custom text search config and
          # define it here for some or all languages.
          #
          # Example:
          #  { german = "my-german" }
          #
          # See https://www.postgresql.org/docs/14/textsearch-tables.html ff.
          pg-config = {
          }

          # Define which query parser to use.
          #
          # https://www.postgresql.org/docs/14/textsearch-controls.html#TEXTSEARCH-PARSING-QUERIES
          pg-query-parser = "websearch_to_tsquery"

          # Allows to define a normalization for the ranking.
          #
          # https://www.postgresql.org/docs/14/textsearch-controls.html#TEXTSEARCH-RANKING
          pg-rank-normalization = [ 4 ]
        }

        # Settings for running the index migration tasks
        migration = {
          # Chunk size to use when indexing data from the database. This
          # many attachments are loaded into memory and pushed to the
          # full-text index.
          index-all-chunk = 10
        }
      }

      addons {
        # A directory to extract addons when running them. Everything in
        # here will be cleared after each run.
        working-dir = ${java.io.tmpdir}"/docspell-addons"

        # A directory for addons to store data between runs. This is not
        # cleared by Docspell and can get large depending on the addons
        # executed.
        #
        # This directory is used as base. In it subdirectories are created
        # per run configuration id.
        cache-dir = ${java.io.tmpdir}"/docspell-addon-cache"

        executor-config {
          # Define a (comma or whitespace separated) list of runners that
          # are responsible for executing an addon. This setting is
          # compared to what is supported by addons. Possible values are:
          #
          # - nix-flake: use nix-flake runner if the addon supports it
          #   (this requires the nix package manager on the joex machine)
          # - docker: use docker
          # - trivial: use the trivial runner
          #
          # The first successful execution is used. This should list all
          # runners the computer supports.
          runner = "nix-flake, docker, trivial"

          # systemd-nspawn can be used to run the program in a container.
          # This is used by runners nix-flake and trivial.
          nspawn = {
            # If this is false, systemd-nspawn is not tried. When true, the
            # addon is executed inside a lightweight container via
            # systemd-nspawn.
            enabled = false

            # Path to sudo command. By default systemd-nspawn is executed
            # via sudo - the user running joex must be allowed to do so NON
            # INTERACTIVELY. If this is empty, then nspawn is tried to
            # execute without sudo.
            sudo-binary = "sudo"

            # Path to the systemd-nspawn command.
            nspawn-binary = "systemd-nspawn"

            # Workaround, if multiple same named containers are run too fast
            container-wait = "100 millis"
          }

          # When multiple addons are executed sequentially, stop after the
          # first failing result. If this is false, then subsequent addons
          # will be run for their side effects only.
          fail-fast = true

          # The timeout for running an addon.
          run-timeout = "15 minutes"

          # Configure the nix flake runner.
          nix-runner {
            # Path to the nix command.
            nix-binary = "nix"

            # The timeout for building the package (running nix build).
            build-timeout = "15 minutes"
          }

          # Configure the docker runner
          docker-runner {
            # Path to the docker command.
            docker-binary = "docker"

            # The timeout for building the package (running docker build).
            build-timeout = "15 minutes"
          }
        }
      }
    }
{{- end -}}
