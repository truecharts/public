{{/* Define the configmap */}}
{{- define "docspell.config" -}}

{{- $serverConfigName := printf "%s-server-config" (include "tc.common.names.fullname" .) }}
{{- $joexConfigName := printf "%s-joex-config" (include "tc.common.names.fullname" .) }}

{{- $server := .Values.rest_server -}}
{{- $joex := .Values.joex -}}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $serverConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DOCSPELL_SERVER_APP__ID: server-{{ randAlphaNum 10 }}
  DOCSPELL_SERVER_BIND_ADDRESS: "0.0.0.0"
  DOCSPELL_SERVER_BIND_PORT: {{ .Values.service.main.ports.main.port }}
  DOCSPELL_SERVER_BASE__URL: {{ $server.base_url | default (printf "%v:%v" "http://localhost" .Values.service.main.ports.main.port) }}
  DOCSPELL_SERVER_INTERNAL__URL: {{ printf "%v:%v" "http://localhost" .Values.service.main.ports.main.port }}
  DOCSPELL_SERVER_BACKEND_JDBC_URL: {{ printf "jdbc:postgresql://%v-%v:5432/%v" .Release.Name "postgresql" .Values.postgresql.postgresqlDatabase }}
  DOCSPELL_SERVER_BACKEND_JDBC_USER: {{ .Values.postgresql.postgresqlUsername }}

  {{- with $server.app_name }}
  DOCSPELL_SERVER_APP__NAME: {{ . }}
  {{- end }}

  {{- with $server.max_item_page_size }}
  DOCSPELL_SERVER_MAX__ITEM__PAGE__SIZE: {{ . | quote }}
  {{- end }}

  {{- with $server.max_item_page_size }}
  DOCSPELL_SERVER_MAX__NOTE__LENGTH: {{ . | quote }}
  {{- end }}

  DOCSPELL_SERVER_SHOW__CLASSIFICATION__SETTINGS: {{ $server.show_classification_settings | quote | default "true" }}

  {{/* Auth */}}
  {{- $auth := $server.auth -}}
  {{- with $auth.session_valid }}
  DOCSPELL_SERVER_AUTH_SESSION__VALID: {{ . }}
  {{- end }}

  DOCSPELL_SERVER_AUTH_REMEMBER__ME_ENABLED: {{ $auth.remember_me.enabled | quote | default "true" }}

  {{- with $auth.remember_me.valid }}
  DOCSPELL_SERVER_AUTH_REMEMBER__ME_VALID: {{ . }}
  {{- end }}

  {{/* Addons */}}
  {{- $addons := $server.addons -}}
  DOCSPELL_SERVER_BACKEND_ADDONS_ENABLED: {{ $addons.enabled | quote | default "false" }}

  DOCSPELL_SERVER_BACKEND_ADDONS_ALLOW__IMPURE: {{ $addons.allow_impure | quote | default "true "}}

  {{- with $addons.allowed_urls }}
  DOCSPELL_SERVER_BACKEND_ADDONS_ALLOWED__URLS: {{ include "utils.quotedList" . | squote }}
  {{- end }}

  {{- with $addons.denied_urls }}
  DOCSPELL_SERVER_BACKEND_ADDONS_DENIED__URLS: {{ include "utils.quotedList" . | squote }}
  {{- end }}

  {{/* Download All */}}
  {{- $downloads := $server.download_all -}}
  {{- with $downloads.max_files }}
  DOCSPELL_SERVER_DOWNLOAD__ALL_MAX__FILES: {{ . | quote }}
  {{- end }}

  {{- with $downloads.max_size }}
  DOCSPELL_SERVER_DOWNLOAD__ALL_MAX__SIZE: {{ . }}
  {{- end }}

  {{/* Logging */}}
  {{- $logging := $server.logging -}}
  {{- with $logging.format }}
  DOCSPELL_SERVER_LOGGING_FORMAT: {{ . }}
  {{- end }}

  {{- with $logging.minimum_level }}
  DOCSPELL_SERVER_LOGGING_MINIMUM__LEVEL: {{ . }}
  {{- end }}

  {{- with $logging.levels.docspell }}
  DOCSPELL_SERVER_LOGGING_LEVELS_DOCSPELL: {{ . }}
  {{- end }}

  {{- with $logging.levels.flywaydb }}
  DOCSPELL_SERVER_LOGGING_LEVELS_"ORG_FLYWAYDB": {{ . }}
  {{- end }}

  {{- with $logging.levels.binny }}
  DOCSPELL_SERVER_LOGGING_LEVELS_BINNY: {{ . }}
  {{- end }}

  {{- with $logging.levels.http4s }}
  DOCSPELL_SERVER_LOGGING_LEVELS_"ORG_HTTP4S": {{ . }}
  {{- end }}

  {{/* Server Options */}}
  {{- $serverOpts := $server.server_opts -}}
  DOCSPELL_SERVER_SERVER__OPTIONS_ENABLE__HTTP__2: {{ $serverOpts.enable_http2 | quote | default "false" }}

  {{- with $serverOpts.max_connections }}
  DOCSPELL_SERVER_SERVER__OPTIONS_MAX__CONNECTIONS: {{ . | quote }}
  {{- end }}

  {{- with $serverOpts.response_timeout }}
  DOCSPELL_SERVER_SERVER__OPTIONS_RESPONSE__TIMEOUT: {{ . }}
  {{- end }}

  {{/* Integration Endpoint */}}
  {{- $integration := $server.integration_endpoint -}}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_ENABLED: {{ $integration.enabled | quote | default "false" }}

  {{- with $integration.priority }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_PRIORITY: {{ . }}
  {{- end }}

  {{- with $integration.source_name }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_SOURCE__NAME: {{ . }}
  {{- end }}

  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_ALLOWED__IPS_ENABLED: {{ $integration.allowed_ips.enabled | quote | default "false" }}

  {{- with $integration.allowed_ips.ips }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_ALLOWED__IPS_IPS: {{ include "utils.quotedList" . | squote }}
  {{- end }}

  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_ENABLED: {{ $integration.http_basic_auth.enabled | quote | default "false" }}

  {{- with $integration.http_basic_auth.realm }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_REALM: {{ . }}
  {{- end }}

  {{- with $integration.http_basic_auth.user }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_USER: {{ . }}
  {{- end }}

  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_ENABLED: {{ $integration.http_header.enabled | quote | default "false" }}

  {{- with $integration.http_header.header_name }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_HEADER__NAME: {{ . }}
  {{- end }}

  {{/* Backend */}}
  {{- $backend := $server.backend -}}
  DOCSPELL_SERVER_BACKEND_MAIL__DEBUG: {{ $backend.mail_debug | quote | default "false" }}

  DOCSPELL_SERVER_BACKEND_DATABASE__SCHEMA_RUN__MAIN__MIGRATIONS: {{ $backend.database_schema.run_main_migrations | quote | default "true" }}

  DOCSPELL_SERVER_BACKEND_DATABASE__SCHEMA_RUN__FIXUP__MIGRATIONS: {{ $backend.database_schema.run_fixup_migrations | quote | default "true" }}

  DOCSPELL_SERVER_BACKEND_DATABASE__SCHEMA_REPAIR__SCHEMA: {{ $backend.database_schema.repair_schema | quote | default "false" }}

  {{- with $backend.signup.mode }}
  DOCSPELL_SERVER_BACKEND_SIGNUP_MODE: {{ . }}
  {{- end }}

  {{- with $backend.signup.invite_time }}
  DOCSPELL_SERVER_BACKEND_SIGNUP_INVITE__TIME: {{ . }}
  {{- end }}

  {{/* Files */}}
  {{- $files := $server.files -}}
  {{- with $files.chunk_size }}
  DOCSPELL_SERVER_BACKEND_FILES_CHUNK__SIZE: {{ . | quote }}
  {{- end }}

  {{- with $files.valid_mime_types }}
  DOCSPELL_SERVER_BACKEND_FILES_VALID__MIME__TYPES: {{ include "utils.quotedList" . | squote }}
  {{- end }}

  {{- with $files.default_store }}
  DOCSPELL_SERVER_BACKEND_FILES_DEFAULT__STORE: {{ . }}
  {{- end }}

  DOCSPELL_SERVER_BACKEND_FILES_STORES_DATABASE_ENABLED: {{ $files.stores.database.enabled | quote | default "true" }}

  DOCSPELL_SERVER_BACKEND_FILES_STORES_DATABASE_TYPE: default-database

  DOCSPELL_SERVER_BACKEND_FILES_STORES_FILESYSTEM_ENABLED: {{ $files.stores.filesystem.enabled | quote | default "false" }}

  DOCSPELL_SERVER_BACKEND_FILES_STORES_FILESYSTEM_TYPE: file-system

  {{- with $files.stores.filesystem.directory }}
  DOCSPELL_SERVER_BACKEND_FILES_STORES_FILESYSTEM_DIRECTORY: {{ . }}
  {{- end }}

  DOCSPELL_SERVER_BACKEND_FILES_STORES_MINIO_ENABLED: {{ $files.stores.minio.enabled | quote | default "false" }}

  DOCSPELL_SERVER_BACKEND_FILES_STORES_MINIO_TYPE: s3

  {{- with $files.stores.minio.endpoint }}
  DOCSPELL_SERVER_BACKEND_FILES_STORES_MINIO_ENDPOINT: {{ . }}
  {{- end }}

  {{- with $files.stores.minio.bucket }}
  DOCSPELL_SERVER_BACKEND_FILES_STORES_MINIO_BUCKET: {{ . }}
  {{- end }}
{{/*
#  Which backend to use, either solr or postgresql
DOCSPELL_SERVER_FULL__TEXT__SEARCH_BACKEND="solr"

#  The full-text search feature can be disabled. It requires an
#  additional index server which needs additional memory and disk
#  space. It can be enabled later any time.
#
#  Currently the SOLR search platform and PostgreSQL is supported.
DOCSPELL_SERVER_FULL__TEXT__SEARCH_ENABLED=false
DOCSPELL_SERVER_FULL__TEXT__SEARCH_POSTGRESQL_JDBC_PASSWORD=""
DOCSPELL_SERVER_FULL__TEXT__SEARCH_POSTGRESQL_JDBC_URL="jdbc:postgresql://server:5432/db"
DOCSPELL_SERVER_FULL__TEXT__SEARCH_POSTGRESQL_JDBC_USER="pguser"

#  Define which query parser to use.
#
#  https://www.postgresql.org/docs/14/textsearch-controls.html#TEXTSEARCH-PARSING-QUERIES
DOCSPELL_SERVER_FULL__TEXT__SEARCH_POSTGRESQL_PG__QUERY__PARSER="websearch_to_tsquery"

#  Whether to use the default database, only works if it is
#  postgresql
DOCSPELL_SERVER_FULL__TEXT__SEARCH_POSTGRESQL_USE__DEFAULT__CONNECTION=false

#  Used to tell solr when to commit the data
DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_COMMIT__WITHIN=1000

#  The defType parameter to lucene that defines the parser to
#  use. You might want to try "edismax" or look here:
#  https://solr.apache.org/guide/8_4/query-syntax-and-parsing.html#query-syntax-and-parsing
DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_DEF__TYPE="lucene"

#  If true, logs request and response bodies
DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_LOG__VERBOSE=false

#  The default combiner for tokens. One of {AND, OR}.
DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_Q__OP="OR"

#  The URL to solr
DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_URL="http://localhost:8983/solr/docspell"

#  When exactly one OIDC/OAuth provider is configured, then the weapp
#  automatically redirects to its authentication page skipping the
#  docspell login page.
DOCSPELL_SERVER_OIDC__AUTO__REDIRECT=true
*/}}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $joexConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DOCSPELL_JOEX_APP__ID: joex-{{ randAlphaNum 10 }}
  DOCSPELL_JOEX_BIND_ADDRESS: "0.0.0.0"
  DOCSPELL_JOEX_BIND_PORT: {{ .Values.service.joex.ports.joex.port }}
  DOCSPELL_JOEX_BASE__URL: {{ printf "%v:%v" "http://localhost" .Values.service.joex.ports.joex.port }}

  {{/* Logging */}}
  {{- $logging := $joex.logging -}}
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
  DOCSPELL_JOEX_LOGGING_LEVELS_"ORG_FLYWAYDB: {{ . }}
  {{- end }}

  {{- with $logging.levels.binny }}
  DOCSPELL_JOEX_LOGGING_LEVELS_BINNY: {{ . }}
  {{- end }}

  {{- with $logging.levels.http4s }}
  DOCSPELL_JOEX_LOGGING_LEVELS_"ORG_HTTP4S: {{ . }}
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

#  Use with care. This repairs all migrations in the database by
#  updating their checksums and removing failed migrations. Good
#  for testing, not recommended for normal operation.
DOCSPELL_JOEX_DATABASE__SCHEMA_REPAIR__SCHEMA=false

#  Whether to run the fixup migrations.
DOCSPELL_JOEX_DATABASE__SCHEMA_RUN__FIXUP__MIGRATIONS=true

#  Whether to run main database migrations.
DOCSPELL_JOEX_DATABASE__SCHEMA_RUN__MAIN__MIGRATIONS=true
DOCSPELL_JOEX_EXTRACTION_OCR_GHOSTSCRIPT_COMMAND_PROGRAM="gs"
DOCSPELL_JOEX_EXTRACTION_OCR_GHOSTSCRIPT_COMMAND_TIMEOUT="5 minutes"
DOCSPELL_JOEX_EXTRACTION_OCR_GHOSTSCRIPT_WORKING__DIR="/tmp/docspell-extraction"

#  Images greater than this size are skipped. Note that every
#  image is loaded completely into memory for doing OCR. This is
#  the pixel count, `height * width` of the image.
DOCSPELL_JOEX_EXTRACTION_OCR_MAX__IMAGE__SIZE=14000000
DOCSPELL_JOEX_EXTRACTION_OCR_PAGE__RANGE_BEGIN=10
DOCSPELL_JOEX_EXTRACTION_OCR_TESSERACT_COMMAND_PROGRAM="tesseract"
DOCSPELL_JOEX_EXTRACTION_OCR_TESSERACT_COMMAND_TIMEOUT="5 minutes"
DOCSPELL_JOEX_EXTRACTION_OCR_UNPAPER_COMMAND_PROGRAM="unpaper"
DOCSPELL_JOEX_EXTRACTION_OCR_UNPAPER_COMMAND_TIMEOUT="5 minutes"
DOCSPELL_JOEX_EXTRACTION_PDF_MIN__TEXT__LEN=500

#  When rendering a pdf page, use this dpi. This results in
#  scaling the image. A standard A4 page rendered at 96dpi
#  results in roughly 790x1100px image. Using 32 results in
#  roughly 200x300px image.
#
#  Note, when this is changed, you might want to re-generate
#  preview images. Check the api for this, there is an endpoint
#  to regenerate all for a collective.
DOCSPELL_JOEX_EXTRACTION_PREVIEW_DPI=32

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

#  Whether this task is enabled
DOCSPELL_JOEX_HOUSE__KEEPING_CHECK__NODES_ENABLED=true

#  How often the node must be unreachable, before it is removed.
DOCSPELL_JOEX_HOUSE__KEEPING_CHECK__NODES_MIN__NOT__FOUND=2

#  Whether to enable clearing old download archives.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__DOWNLOADS_ENABLED=true

#  The minimum age of a download file to be deleted.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__DOWNLOADS_OLDER__THAN="14 days"

#  Whether this task is enabled.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__INVITES_ENABLED=true

#  The minimum age of invites to be deleted.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__INVITES_OLDER__THAN="30 days"

#  This defines how many jobs are deleted in one transaction.
#  Since the data to delete may get large, it can be configured
#  whether more or less memory should be used.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__JOBS_DELETE__BATCH="100"

#  Whether this task is enabled.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__JOBS_ENABLED=true

#  The minimum age of jobs to delete. It is matched against the
#  `finished' timestamp.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__JOBS_OLDER__THAN="30 days"

#  Whether the job is enabled.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__REMEMBER__ME_ENABLED=true

#  The minimum age of tokens to be deleted.
DOCSPELL_JOEX_HOUSE__KEEPING_CLEANUP__REMEMBER__ME_OLDER__THAN="30 days"
DOCSPELL_JOEX_HOUSE__KEEPING_INTEGRITY__CHECK_ENABLED=true

#  When the house keeping tasks execute. Default is to run every
#  week.
DOCSPELL_JOEX_HOUSE__KEEPING_SCHEDULE="Sun *-*-* 00:00:00 UTC"

#  The database password.
DOCSPELL_JOEX_JDBC_PASSWORD=""
DOCSPELL_JOEX_JDBC_URL="jdbc:h2:///tmp/docspell-demo.db;MODE=PostgreSQL;DATABASE_TO_LOWER=TRUE;AUTO_SERVER=TRUE"

#  The database user.
DOCSPELL_JOEX_JDBC_USER="sa"


#  Enable or disable debugging for e-mail related functionality. This
#  applies to both sending and receiving mails. For security reasons
#  logging is not very extensive on authentication failures. Setting
#  this to true, results in a lot of data printed to stdout.
DOCSPELL_JOEX_MAIL__DEBUG=false

#  This is the id of this node. If you run more than one server, you
#  have to make sure to provide unique ids per node.
DOCSPELL_JOEX_PERIODIC__SCHEDULER_NAME="joex1"

#  A fallback to start looking for due periodic tasks regularily.
#  Usually joex instances should be notified via REST calls if
#  external processes change tasks. But these requests may get
#  lost.
DOCSPELL_JOEX_PERIODIC__SCHEDULER_WAKEUP__PERIOD="10 minutes"

#  A counting scheme determines the ratio of how high- and low-prio
#  jobs are run. For example: 4,1 means run 4 high prio jobs, then
#  1 low prio and then start over.
DOCSPELL_JOEX_SCHEDULER_COUNTING__SCHEME="4,1"

#  The queue size of log statements from a job.
DOCSPELL_JOEX_SCHEDULER_LOG__BUFFER__SIZE=500

#  This is the id of this node. If you run more than one server, you
#  have to make sure to provide unique ids per node.
DOCSPELL_JOEX_SCHEDULER_NAME="joex1"

#  Number of processing allowed in parallel.
DOCSPELL_JOEX_SCHEDULER_POOL__SIZE=1

#  How often a failed job should be retried until it enters failed
#  state. If a job fails, it becomes "stuck" and will be retried
#  after a delay.
DOCSPELL_JOEX_SCHEDULER_RETRIES=2

#  The delay until the next try is performed for a failed job. This
#  delay is increased exponentially with the number of retries.
DOCSPELL_JOEX_SCHEDULER_RETRY__DELAY="1 minute"

#  If no job is left in the queue, the scheduler will wait until a
#  notify is requested (using the REST interface). To also retry
#  stuck jobs, it will notify itself periodically.
DOCSPELL_JOEX_SCHEDULER_WAKEUP__PERIOD="30 minutes"

#  This is used as the List-Id e-mail header when mails are sent
#  from docspell to its users (example: for notification mails). It
#  is not used when sending to external recipients. If it is empty,
#  no such header is added. Using this header is often useful when
#  filtering mails.
#
#  It should be a string in angle brackets. See
#  https://tools.ietf.org/html/rfc2919 for a formal specification
#  of this header.
DOCSPELL_JOEX_SEND__MAIL_LIST__ID=""

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

#  The body of the mail. Subject and body can contain these
#  variables which are replaced:
#
#  - `latestVersion` the latest available version of Docspell
#  - `currentVersion` the currently running (old) version of Docspell
#  - `releasedAt` a date when the release was published
#
#  The body is processed as markdown after the variables have been
#  replaced.
DOCSPELL_JOEX_UPDATE__CHECK_BODY="\nHello,\n\nYou are currently running Docspell {{ currentVersion }}. Version *{{ latestVersion }}*\nis now available, which was released on {{ releasedAt }}. Check the release page at:\n\n<https://github.com/eikek/docspell/releases/latest>\n\nHave a nice day!\n\nDocpell Update Check\n"

#  Whether to enable this task
DOCSPELL_JOEX_UPDATE__CHECK_ENABLED=false

#  When the update check should execute. Default is to run every
#  week. You can specify a time zone identifier, like
#  'Europe/Berlin' at the end.
DOCSPELL_JOEX_UPDATE__CHECK_SCHEDULE="Sun *-*-* 00:00:00 UTC"

#  An account id in form of `collective/user` (or just `user` if
#  collective and user name are the same). This user account must
#  have at least one valid SMTP settings which are used to send the
#  mail.
DOCSPELL_JOEX_UPDATE__CHECK_SENDER__ACCOUNT=""

#  The SMTP connection id that should be used for sending the mail.
DOCSPELL_JOEX_UPDATE__CHECK_SMTP__ID=""

#  The subject of the mail. It supports the same variables as the
#  body.
DOCSPELL_JOEX_UPDATE__CHECK_SUBJECT="Docspell {{ latestVersion }} is available"

#  Sends the mail without checking the latest release. Can be used
#  if you want to see if mail sending works, but don't want to wait
#  until a new release is published.
DOCSPELL_JOEX_UPDATE__CHECK_TEST__RUN=false

#  How many mails (headers only) to retrieve in one chunk.
#
#  If this is greater than `max-mails' it is set automatically to
#  the value of `max-mails'.
DOCSPELL_JOEX_USER__TASKS_SCAN__MAILBOX_MAIL__CHUNK__SIZE=50

#  A limit of how many folders to scan through. If a user
#  configures more than this, only upto this limit folders are
#  scanned and a warning is logged.
DOCSPELL_JOEX_USER__TASKS_SCAN__MAILBOX_MAX__FOLDERS=50

#  A limit on how many mails to process in one job run. This is
#  meant to avoid too heavy resource allocation to one
#  user/collective.
#
#  If more than this number of mails is encountered, a warning is
#  logged.
DOCSPELL_JOEX_USER__TASKS_SCAN__MAILBOX_MAX__MAILS=500
*/}}
{{- end -}}

{{- define "utils.quotedList" -}}
{{- $local := dict "first" true -}}
{{/* This results in "["item","item"]" */}}
{{- "[" -}}{{- range $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v | quote -}}{{- $_ := set $local "first" false -}}{{- end -}}{{- "]" -}}
{{- end -}}
