{{/* Define the configmap */}}
{{- define "docspell-joex.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: docspell-joex-env
data:
  DOCSPELL_JOEX_JDBC_USER: "{{ .Values.postgresql.postgresqlUsername }}"
  {{/* General */}}
  DOCSPELL_JOEX_APP__ID: "{{ .Values.joex.app.id }}"
  DOCSPELL_JOEX_FILES_CHUNK__SIZE: "{{ .Values.joex.app.chunk_size }}"
  DOCSPELL_JOEX_BASE__URL: "{{ .Values.joex.app.base_url }}"
  DOCSPELL_JOEX_BIND_ADDRESS: "{{ .Values.joex.app.bind_address }}"
  DOCSPELL_JOEX_BIND_PORT: "{{ .Values.joex.app.bind_port }}"
  {{/* SOLR */}}
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_ENABLED: "{{ .Values.joex.solr.enabled }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_URL: "{{ .Values.joex.solr.url }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_COMMIT__WITHIN: "{{ .Values.joex.solr.commit_within }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_DEF__TYPE: "{{ .Values.joex.solr.parser }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_Q__OP: "{{ .Values.joex.solr.combiner }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_MIGRATION_INDEX__ALL__CHUNK: "{{ .Values.joex.solr.index_chunk }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_LOG__VERBOSE: "{{ .Values.joex.solr.logs_verbose }}"
  {{/* Convert */}}
  DOCSPELL_JOEX_CONVERT_CHUNK__SIZE: "{{ .Values.joex.convert.chunk_size }}"
  DOCSPELL_JOEX_CONVERT_CONVERTED__FILENAME__PART: "{{ .Values.joex.convert.converted_filename_part }}"
  DOCSPELL_JOEX_CONVERT_DECRYPT__PDF_ENABLED: "{{ .Values.joex.convert.decrypt_pdf_enabled }}"
  DOCSPELL_JOEX_CONVERT_MARKDOWN_INTERNAL__CSS: "{{ .Values.joex.convert.md_internal_css }}"
  DOCSPELL_JOEX_CONVERT_MAX__IMAGE__SIZE: "{{ .Values.joex.convert.md_internal_css }}"
  DOCSPELL_JOEX_CONVERT_OCRMYPDF_ENABLED: "{{ .Values.joex.convert.ocrmypdf_enabled }}"
  DOCSPELL_JOEX_CONVERT_OCRMYPDF_COMMAND_PROGRAM: "{{ .Values.joex.convert.ocrmypdf_cmd_program }}"
  DOCSPELL_JOEX_CONVERT_OCRMYPDF_COMMAND_TIMEOUT: "{{ .Values.joex.convert.ocrmypdf_cmd_timeout }}"
  DOCSPELL_JOEX_CONVERT_OCRMYPDF_WORKING__DIR: "{{ .Values.joex.convert.ocrmypdf_workdir }}"
  DOCSPELL_JOEX_CONVERT_TESSERACT_COMMAND_PROGRAM: "{{ .Values.joex.convert.tesseract_cmd_program }}"
  DOCSPELL_JOEX_CONVERT_TESSERACT_COMMAND_TIMEOUT: "{{ .Values.joex.convert.tesseract_cmd_timeout }}"
  DOCSPELL_JOEX_CONVERT_TESSERACT_WORKING__DIR: "{{ .Values.joex.convert.tesseract_workdir }}"
  DOCSPELL_JOEX_CONVERT_UNOCONV_COMMAND_PROGRAM: "{{ .Values.joex.convert.unoconv_cmd_program}}"
  DOCSPELL_JOEX_CONVERT_UNOCONV_COMMAND_TIMEOUT: "{{ .Values.joex.convert.unoconv_cmd_timeout }}"
  DOCSPELL_JOEX_CONVERT_UNOCONV_WORKING__DIR: "{{ .Values.joex.convert.unoconv_workdir }}"
  DOCSPELL_JOEX_CONVERT_WKHTMLPDF_COMMAND_PROGRAM: "{{ .Values.joex.convert.wkhtmlpdf_cmd_program }}"
  DOCSPELL_JOEX_CONVERT_WKHTMLPDF_COMMAND_TIMEOUT: "{{ .Values.joex.convert.wkhtmlpdf_cmd_timeout }}"
  DOCSPELL_JOEX_CONVERT_WKHTMLPDF_WORKING__DIR: "{{ .Values.joex.convert.whhtmlpdf_workdir }}"
{{- end -}}
