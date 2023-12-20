{{/* Define the configmap */}}
{{- define "projectsend.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $db := .Values.mariadb.mariadbDatabase -}}
{{- $dbuser := .Values.mariadb.mariadbUsername -}}
{{- $dbpassword := .Values.mariadb.creds.mariadbPassword | trimAll "\"" -}}
{{- $dbhost := .Values.mariadb.creds.plainhost | trimAll "\"" -}}

projectsend-config:
  enabled: true
  data:
    sys.config.php: |
     <?php
      define('DB_DRIVER', 'mysql');

      define('DB_NAME', "{{ $db }}");
      define('DB_HOST', "{{ $dbhost }}");
      define('DB_USER', "{{ $dbuser }}");

      define('DB_PASSWORD', "{{ $dbpassword }}");
      define('TABLES_PREFIX', 'tbl_');

      define('SITE_LANG','en');
      define('MAX_FILESIZE',2048);
      define('EMAIL_ENCODING', 'utf-8');
      define('DEBUG', false);
{{- end -}}
