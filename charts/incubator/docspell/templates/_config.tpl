{{/* Define the configmap */}}
{{- define "docspell.config" -}}

{{- $serverConfigName := printf "%s-server-config" (include "tc.common.names.fullname" .) }}
{{- $joexConfigName := printf "%s-joex-config" (include "tc.common.names.fullname" .) }}

{{- $server := .Values.rest_server -}}
{{- $serverID := printf "server-%v" (randAlphaNum 10) -}}

{{- $joex := .Values.joex -}}
{{- $joexID := printf "joex-%v" (randAlphaNum 10) -}}

---
{{- $logging := $joex.logging -}}
{{- $database_schema := $joex.database_schema -}}
{{- $send_mail := $joex.send_mail -}}
{{- $scheduler := $joex.scheduler -}}
{{- $periodic_scheduler := $joex.periodic_scheduler -}}
{{- $user_tasks := $joex.user_tasks -}}
{{- $house_keeping := $joex.house_keeping -}}
{{- $extraction := $joex.extraction -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $joexConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DOCSPELL_JOEX_APP__ID: {{ $joexID }}

  DOCSPELL_JOEX_BASE__URL: {{ printf "%v:%v" "http://localhost" .Values.service.joex.ports.joex.port }}

  DOCSPELL_JOEX_BIND_ADDRESS: "0.0.0.0"

  DOCSPELL_JOEX_BIND_PORT: {{ .Values.service.joex.ports.joex.port | quote }}

  {{/* Logging */}}
  {{- with $logging.format }}
  DOCSPELL_JOEX_LOGGING_FORMAT: {{ . }}
  {{- end }}

  {{- with $logging.minimum_level }}
  DOCSPELL_JOEX_LOGGING_MINIMUM__LEVEL: {{ . }}
  {{- end }}

  {{- with $logging.levels.docspell }}
  DOCSPELL_JOEX_LOGGING_LEVELS_DOCSPELL: {{ . }}
  {{- end }}

  {{- with $logging.levels.flywaydb }}
  {{/*
  DOCSPELL_JOEX_LOGGING_LEVELS_"ORG_FLYWAYDB": {{ . }}
  */}}
  {{- end }}

  {{- with $logging.levels.binny }}
  DOCSPELL_JOEX_LOGGING_LEVELS_BINNY: {{ . }}
  {{- end }}

  {{- with $logging.levels.http4s }}
  {{/*
  DOCSPELL_JOEX_LOGGING_LEVELS_"ORG_HTTP4S": {{ . }}
  */}}
  {{- end }}

  DOCSPELL_JOEX_JDBC_URL: {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase }}

  DOCSPELL_JOEX_JDBC_USER: {{ .Values.postgresql.postgresqlUsername }}

  {{/* Database Schema */}}
  DOCSPELL_JOEX_DATABASE__SCHEMA_RUN__MAIN__MIGRATIONS: {{ $database_schema.run_main_migrations | default true | quote }}

  DOCSPELL_JOEX_DATABASE__SCHEMA_RUN__FIXUP__MIGRATIONS: {{ $database_schema.run_fixup_migrations | default true | quote }}

  DOCSPELL_JOEX_DATABASE__SCHEMA_REPAIR__SCHEMA: {{ $database_schema.repair_schema | default false | quote }}

  DOCSPELL_JOEX_MAIL__DEBUG: {{ $joex.mail_debug | default false | quote }}

  {{/* Send Mail */}}
  {{- with $send_mail.list_id }}
  DOCSPELL_JOEX_SEND__MAIL_LIST__ID: {{ . }}
  {{- end }}

  DOCSPELL_JOEX_SCHEDULER_NAME: {{ $joexID }}

  {{/* Scheduler */}}
  {{- with $scheduler.pool_size }}
  DOCSPELL_JOEX_SCHEDULER_POOL__SIZE: {{ . | quote }}
  {{- end }}

  {{- with $scheduler.counting_scheme }}
  DOCSPELL_JOEX_SCHEDULER_COUNTING__SCHEME: {{ . | quote }}
  {{- end }}

  {{- with $scheduler.retries }}
  DOCSPELL_JOEX_SCHEDULER_RETRIES: {{ . | quote }}
  {{- end }}

  {{- with $scheduler.retry_delay }}
  DOCSPELL_JOEX_SCHEDULER_RETRY__DELAY: {{ . }}
  {{- end }}

  {{- with $scheduler.log_buffer_size }}
  DOCSPELL_JOEX_SCHEDULER_LOG__BUFFER__SIZE: {{ . | quote }}
  {{- end }}

  {{- with $scheduler.wakeup_period }}
  DOCSPELL_JOEX_SCHEDULER_WAKEUP__PERIOD: {{ . }}
  {{- end }}

  {{/* Periodic Scheduler */}}
  DOCSPELL_JOEX_PERIODIC__SCHEDULER_NAME: {{ $joexID }}

  {{- with $periodic_scheduler.wakeup_period }}
  DOCSPELL_JOEX_PERIODIC__SCHEDULER_WAKEUP__PERIOD: {{ . }}
  {{- end }}

  {{/* User Tasks */}}
  {{- with $user_tasks.scan_mailbox.max_folders }}
  DOCSPELL_JOEX_USER__TASKS_SCAN__MAILBOX_MAX__FOLDERS: {{ . | quote }}
  {{- end }}

  {{- with $user_tasks.scan_mailbox.mail_chunk_size }}
  DOCSPELL_JOEX_USER__TASKS_SCAN__MAILBOX_MAIL__CHUNK__SIZE: {{ . | quote }}
  {{- end }}

  {{- with $user_tasks.scan_mailbox.max_mails }}
  DOCSPELL_JOEX_USER__TASKS_SCAN__MAILBOX_MAX__MAILS: {{ . | quote }}
  {{- end }}

  {{/* House Keeping */}}
  {{- with $house_keeping.schedule }}
  DOCSPELL_JOEX_HOUSE__KEEPING_SCHEDULE: {{ . }}
  {{- end }}

  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__INVITES_ENABLED: {{ $house_keeping.cleanup_invites.enabled | default true | quote }}

  {{- with $house_keeping.cleanup_invites.older_than }}
  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__INVITES_OLDER__THAN: {{ . }}
  {{- end }}

  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__REMEMBER__ME_ENABLED: {{ $house_keeping.cleanup_remember_me.enabled | default true | quote }}

  {{- with $house_keeping.cleanup_remember_me.older_than }}
  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__REMEMBER__ME_OLDER__THAN: {{ . }}
  {{- end }}

  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__JOBS_ENABLED: {{ $house_keeping.cleanup_jobs.enabled | default true | quote }}

  {{- with $house_keeping.cleanup_jobs.older_than }}
  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__JOBS_OLDER__THAN: {{ . }}
  {{- end }}

  {{- with $house_keeping.cleanup_jobs.delete_batch }}
  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__JOBS_DELETE__BATCH: {{ . | quote }}
  {{- end }}

  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__DOWNLOADS_ENABLED: {{ $house_keeping.cleanup_downloads.enabled | default true | quote }}

  {{- with $house_keeping.cleanup_downloads.older_than }}
  DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__DOWNLOADS_OLDER__THAN: {{ . }}
  {{- end }}

  DOCSPELL_JOEX_HOUSE__KEEPING_CHECK__NODES_ENABLED: {{ $house_keeping.check_nodes.enabled | default true | quote }}

  {{- with $house_keeping.check_nodes.min_not_found }}
  DOCSPELL_JOEX_HOUSE__KEEPING_CHECK__NODES_MIN__NOT__FOUND: {{ . | quote }}
  {{- end }}

  DOCSPELL_JOEX_HOUSE__KEEPING_INTEGRITY__CHECK_ENABLED: {{ $house_keeping.integrity_check.enabled | default true | quote }}

  DOCSPELL_JOEX_UPDATE__CHECK_ENABLED: {{ $house_keeping.update_check.enabled | default false | quote }}

  DOCSPELL_JOEX_UPDATE__CHECK_TEST__RUN: {{ $house_keeping.update_check.test_run | default false | quote }}

  {{- with $house_keeping.update_check.schedule }}
  DOCSPELL_JOEX_UPDATE__CHECK_SCHEDULE: {{ . }}
  {{- end }}

  {{- with $house_keeping.update_check.sender_account }}
  DOCSPELL_JOEX_UPDATE__CHECK_SENDER__ACCOUNT: {{ . }}
  {{- end }}

  {{- with $house_keeping.update_check.smtp_id }}
  DOCSPELL_JOEX_UPDATE__CHECK_SMTP__ID: {{ . }}
  {{- end }}

  {{- with $house_keeping.update_check.recipients }}
  # TODO:
  DOCSPELL_JOEX_UPDATE__CHECK_RECIPIENTS: {{ . }}
  {{- end }}

  {{- with $house_keeping.update_check.subject }}
  DOCSPELL_JOEX_UPDATE__CHECK_SUBJECT: {{ . }}
  {{- end }}

  {{- with $house_keeping.update_check.body }}
  DOCSPELL_JOEX_UPDATE__CHECK_BODY: {{ . }}
  {{- end }}

  {{- with $extraction.pdf.min_text_length }}
  DOCSPELL_JOEX_EXTRACTION_PDF_MIN__TEXT__LEN: {{ . | quote }}
  {{- end }}

  {{- with $extraction.preview.dpi }}
  DOCSPELL_JOEX_EXTRACTION_PREVIEW_DPI: {{ . | quote }}
  {{- end }}

  {{- with $extraction.ocr.max_image_size }}
  DOCSPELL_JOEX_EXTRACTION_OCR_MAX__IMAGE__SIZE: {{ . | quote }}
  {{- end }}

  {{- with $extraction.ocr.page_range.begin }}
  DOCSPELL_JOEX_EXTRACTION_OCR_PAGE__RANGE_BEGIN: {{ . | quote }}
  {{- end }}

  {{- with $extraction.ghost_script.command.program }}
  DOCSPELL_JOEX_EXTRACTION_OCR_GHOSTSCRIPT_COMMAND_PROGRAM: {{ . }}
  {{- end }}

  {{- with $extraction.ghost_script.command.timeout }}
  DOCSPELL_JOEX_EXTRACTION_OCR_GHOSTSCRIPT_COMMAND_TIMEOUT: {{ . }}
  {{- end }}

  {{- with $extraction.ghost_script.work_dir }}
  DOCSPELL_JOEX_EXTRACTION_OCR_GHOSTSCRIPT_WORKING__DIR: {{ . }}
  {{- end }}

  {{- with $extraction.unpaper.command.program }}
  DOCSPELL_JOEX_EXTRACTION_OCR_UNPAPER_COMMAND_PROGRAM: {{ . }}
  {{- end }}

  {{- with $extraction.unpaper.command.timetout }}
  DOCSPELL_JOEX_EXTRACTION_OCR_UNPAPER_COMMAND_TIMEOUT: {{ . }}
  {{- end }}

  {{- with $extraction.tesseract.command.program }}
  DOCSPELL_JOEX_EXTRACTION_OCR_TESSERACT_COMMAND_PROGRAM: {{ . }}
  {{- end }}

  {{- with $extraction.tesseract.command.timetout }}
  DOCSPELL_JOEX_EXTRACTION_OCR_TESSERACT_COMMAND_TIMEOUT: {{ . }}
  {{- end }}

{{/*

#### JOEX Configuration ####
DOCSPELL_JOEX_ADDONS_CACHE__DIR="/tmp/docspell-addon-cache"

#  The timeout for building the package (running docker build).
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_DOCKER__RUNNER_BUILD__TIMEOUT="15 minutes"

#  Path to the docker command.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_DOCKER__RUNNER_DOCKER__BINARY="docker"

#  When multiple addons are executed sequentially, stop after the
#  first failing result. If this is false, then subsequent addons
#  will be run for their side effects only.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_FAIL__FAST=true

#  The timeout for building the package (running nix build).
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_NIX__RUNNER_BUILD__TIMEOUT="15 minutes"

#  Path to the nix command.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_NIX__RUNNER_NIX__BINARY="nix"

#  Workaround, if multiple same named containers are run too fast
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_NSPAWN_CONTAINER__WAIT="100 millis"

#  If this is false, systemd-nspawn is not tried. When true, the
#  addon is executed inside a lightweight container via
#  systemd-nspawn.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_NSPAWN_ENABLED=false

#  Path to the systemd-nspawn command.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_NSPAWN_NSPAWN__BINARY="systemd-nspawn"

#  Path to sudo command. By default systemd-nspawn is executed
#  via sudo - the user running joex must be allowed to do so NON
#  INTERACTIVELY. If this is empty, then nspawn is tried to
#  execute without sudo.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_NSPAWN_SUDO__BINARY="sudo"

#  The timeout for running an addon.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_RUN__TIMEOUT="15 minutes"

#  Define a (comma or whitespace separated) list of runners that
#  are responsible for executing an addon. This setting is
#  compared to what is supported by addons. Possible values are:
#
#  - nix-flake: use nix-flake runner if the addon supports it
#    (this requires the nix package manager on the joex machine)
#  - docker: use docker
#  - trivial: use the trivial runner
#
#  The first successful execution is used. This should list all
#  runners the computer supports.
DOCSPELL_JOEX_ADDONS_EXECUTOR__CONFIG_RUNNER="nix-flake, docker, trivial"
DOCSPELL_JOEX_ADDONS_WORKING__DIR="/tmp/docspell-addons"

#  Defines the chunk size (in bytes) used to store the files.
#  This will affect the memory footprint when uploading and
#  downloading files. At most this amount is loaded into RAM for
#  down- and uploading.
#
#  It also defines the chunk size used for the blobs inside the
#  database.
DOCSPELL_JOEX_CONVERT_CHUNK__SIZE=524288

#  A string used to change the filename of the converted pdf file.
#  If empty, the original file name is used for the pdf file ( the
#  extension is always replaced with `pdf`).
DOCSPELL_JOEX_CONVERT_CONVERTED__FILENAME__PART="converted"
DOCSPELL_JOEX_CONVERT_DECRYPT__PDF_ENABLED=true

#  The CSS that is used to style the resulting HTML.
DOCSPELL_JOEX_CONVERT_MARKDOWN_INTERNAL__CSS="\n        body { padding: 2em 5em; }\n      "

#  Images greater than this size are skipped. Note that every
#  image is loaded completely into memory for doing OCR. This is
#  the pixel count, `height * width` of the image.
DOCSPELL_JOEX_CONVERT_MAX__IMAGE__SIZE=14000000
DOCSPELL_JOEX_CONVERT_OCRMYPDF_COMMAND_PROGRAM="ocrmypdf"
DOCSPELL_JOEX_CONVERT_OCRMYPDF_COMMAND_TIMEOUT="5 minutes"
DOCSPELL_JOEX_CONVERT_OCRMYPDF_ENABLED=true
DOCSPELL_JOEX_CONVERT_OCRMYPDF_WORKING__DIR="/tmp/docspell-convert"
DOCSPELL_JOEX_CONVERT_TESSERACT_COMMAND_PROGRAM="tesseract"
DOCSPELL_JOEX_CONVERT_TESSERACT_COMMAND_TIMEOUT="5 minutes"
DOCSPELL_JOEX_CONVERT_TESSERACT_WORKING__DIR="/tmp/docspell-convert"
DOCSPELL_JOEX_CONVERT_UNOCONV_COMMAND_PROGRAM="unoconv"
DOCSPELL_JOEX_CONVERT_UNOCONV_COMMAND_TIMEOUT="2 minutes"
DOCSPELL_JOEX_CONVERT_UNOCONV_WORKING__DIR="/tmp/docspell-convert"
DOCSPELL_JOEX_CONVERT_WKHTMLPDF_COMMAND_PROGRAM="wkhtmltopdf"
DOCSPELL_JOEX_CONVERT_WKHTMLPDF_COMMAND_TIMEOUT="2 minutes"
DOCSPELL_JOEX_CONVERT_WKHTMLPDF_WORKING__DIR="/tmp/docspell-convert"

#  Defines the chunk size (in bytes) used to store the files.
#  This will affect the memory footprint when uploading and
#  downloading files. At most this amount is loaded into RAM for
#  down- and uploading.
#
#  It also defines the chunk size used for the blobs inside the
#  database.
DOCSPELL_JOEX_FILES_CHUNK__SIZE=524288

#  The id of an enabled store from the `stores` array that should
#  be used.
#
#  IMPORTANT NOTE: All nodes must have the exact same file store
#  configuration!
DOCSPELL_JOEX_FILES_DEFAULT__STORE="database"
DOCSPELL_JOEX_FILES_STORES_DATABASE_ENABLED=true
DOCSPELL_JOEX_FILES_STORES_DATABASE_TYPE="default-database"
DOCSPELL_JOEX_FILES_STORES_FILESYSTEM_DIRECTORY="/some/directory"
DOCSPELL_JOEX_FILES_STORES_FILESYSTEM_ENABLED=false
DOCSPELL_JOEX_FILES_STORES_FILESYSTEM_TYPE="file-system"
DOCSPELL_JOEX_FILES_STORES_MINIO_ACCESS__KEY="username"
DOCSPELL_JOEX_FILES_STORES_MINIO_BUCKET="docspell"
DOCSPELL_JOEX_FILES_STORES_MINIO_ENABLED=false
DOCSPELL_JOEX_FILES_STORES_MINIO_ENDPOINT="http://localhost:9000"
DOCSPELL_JOEX_FILES_STORES_MINIO_SECRET__KEY="password"
DOCSPELL_JOEX_FILES_STORES_MINIO_TYPE="s3"

#  Which backend to use, either solr or postgresql
DOCSPELL_JOEX_FULL__TEXT__SEARCH_BACKEND="solr"

#  The full-text search feature can be disabled. It requires an
#  additional index server which needs additional memory and disk
#  space. It can be enabled later any time.
#
#  Currently the SOLR search platform and PostgreSQL is supported.
DOCSPELL_JOEX_FULL__TEXT__SEARCH_ENABLED=false

#  Chunk size to use when indexing data from the database. This
#  many attachments are loaded into memory and pushed to the
#  full-text index.
DOCSPELL_JOEX_FULL__TEXT__SEARCH_MIGRATION_INDEX__ALL__CHUNK=10
DOCSPELL_JOEX_FULL__TEXT__SEARCH_POSTGRESQL_JDBC_PASSWORD=""
DOCSPELL_JOEX_FULL__TEXT__SEARCH_POSTGRESQL_JDBC_URL="jdbc:postgresql://server:5432/db"
DOCSPELL_JOEX_FULL__TEXT__SEARCH_POSTGRESQL_JDBC_USER="pguser"

#  Define which query parser to use.
#
#  https://www.postgresql.org/docs/14/textsearch-controls.html#TEXTSEARCH-PARSING-QUERIES
DOCSPELL_JOEX_FULL__TEXT__SEARCH_POSTGRESQL_PG__QUERY__PARSER="websearch_to_tsquery"

#  Whether to use the default database, only works if it is
#  postgresql
DOCSPELL_JOEX_FULL__TEXT__SEARCH_POSTGRESQL_USE__DEFAULT__CONNECTION=false

#  Used to tell solr when to commit the data
DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_COMMIT__WITHIN=1000

#  The defType parameter to lucene that defines the parser to
#  use. You might want to try "edismax" or look here:
#  https://solr.apache.org/guide/8_4/query-syntax-and-parsing.html#query-syntax-and-parsing
DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_DEF__TYPE="lucene"

#  If true, logs request and response bodies
DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_LOG__VERBOSE=false

#  The default combiner for tokens. One of {AND, OR}.
DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_Q__OP="OR"

#  The URL to solr
DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_URL="http://localhost:8983/solr/docspell"

#  Whether to enable classification globally. Each collective can
#  enable/disable auto-tagging. The classifier is also used for
#  finding correspondents and concerned entities, if enabled
#  here.
DOCSPELL_JOEX_TEXT__ANALYSIS_CLASSIFICATION_ENABLED=true

#  If concerned with memory consumption, this restricts the
#  number of items to consider. More are better for training. A
#  negative value or zero means to train on all items.
#
#  This limit and `text-analysis.max-length` define how much
#  memory is required. On weaker hardware, it is advised to play
#  with these values.
DOCSPELL_JOEX_TEXT__ANALYSIS_CLASSIFICATION_ITEM__COUNT=600

#  Maximum length of text to be analysed.
#
#  All text to analyse must fit into RAM. A large document may take
#  too much heap. Also, most important information is at the
#  beginning of a document, so in most cases the first two pages
#  should suffice. Default is 5000, which are about 2 pages (just a
#  rough guess, of course). For my data, more than 80% of the
#  documents are less than 5000 characters.
#
#  This values applies to nlp and the classifier. If this value is
#  <= 0, the limit is disabled.
DOCSPELL_JOEX_TEXT__ANALYSIS_MAX__LENGTH=5000

#  The StanfordCoreNLP library caches language models which
#  requires quite some amount of memory. Setting this interval to a
#  positive duration, the cache is cleared after this amount of
#  idle time. Set it to 0 to disable it if you have enough memory,
#  processing will be faster.
#
#  This has only any effect, if mode != disabled.
DOCSPELL_JOEX_TEXT__ANALYSIS_NLP_CLEAR__INTERVAL="15 minutes"

#  Restricts proposals for due dates. Only dates earlier than this
#  number of years in the future are considered.
DOCSPELL_JOEX_TEXT__ANALYSIS_NLP_MAX__DUE__DATE__YEARS=10

#  The mode for configuring NLP models:
#
#  1. full – builds the complete pipeline
#  2. basic - builds only the ner annotator
#  3. regexonly - matches each entry in your address book via regexps
#  4. disabled - doesn't use any stanford-nlp feature
#
#  The full and basic variants rely on pre-build language models
#  that are available for only a few languages. Memory usage
#  varies among the languages. So joex should run with -Xmx1400M
#  at least when using mode=full.
#
#  The basic variant does a quite good job for German and
#  English. It might be worse for French, always depending on the
#  type of text that is analysed. Joex should run with about 500M
#  heap, here again lanugage German uses the most.
#
#  The regexonly variant doesn't depend on a language. It roughly
#  works by converting all entries in your addressbook into
#  regexps and matches each one against the text. This can get
#  memory intensive, too, when the addressbook grows large. This
#  is included in the full and basic by default, but can be used
#  independently by setting mode=regexner.
#
#  When mode=disabled, then the whole nlp pipeline is disabled,
#  and you won't get any suggestions. Only what the classifier
#  returns (if enabled).
DOCSPELL_JOEX_TEXT__ANALYSIS_NLP_MODE="full"

#  The NER annotation uses a file of patterns that is derived
#  from a collective's address book. This is is the time how
#  long this data will be kept until a check for a state change
#  is done.
DOCSPELL_JOEX_TEXT__ANALYSIS_NLP_REGEX__NER_FILE__CACHE__TIME="1 minute"

#  Whether to enable custom NER annotation. This uses the
#  address book of a collective as input for NER tagging (to
#  automatically find correspondent and concerned entities). If
#  the address book is large, this can be quite memory
#  intensive and also makes text analysis much slower. But it
#  improves accuracy and can be used independent of the
#  lanugage. If this is set to 0, it is effectively disabled
#  and NER tagging uses only statistical models (that also work
#  quite well, but are restricted to the languages mentioned
#  above).
#
#  Note, this is only relevant if nlp-config.mode is not
#  "disabled".
DOCSPELL_JOEX_TEXT__ANALYSIS_NLP_REGEX__NER_MAX__ENTRIES=1000
DOCSPELL_JOEX_TEXT__ANALYSIS_WORKING__DIR="/tmp/docspell-analysis"
*/}}
{{- end -}}

{{- define "utils.quotedList" -}}
{{- $local := dict "first" true -}}
{{/* This results in "["item","item"]" */}}
{{- "[" -}}{{- range $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v | quote -}}{{- $_ := set $local "first" false -}}{{- end -}}{{- "]" -}}
{{- end -}}
