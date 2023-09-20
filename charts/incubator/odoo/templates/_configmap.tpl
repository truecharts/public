{{/* Define the configmap */}}
{{- define "odoo.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $admin := .Values.odoo.admin -}}
{{- $smtp := .Values.odoo.smtp -}}

{{- $pgdb := .Values.cnpg.main.database -}}
{{- $pguser := .Values.cnpg.main.user -}}
{{- $pgpassword := .Values.cnpg.main.creds.password | trimAll "\"" -}}
{{- $pghost := .Values.cnpg.main.creds.host -}}

odoo-config:
  enabled: true
  data:
    odoo.conf: |
     [options]
       addons_path = {{ .Values.persistence.addons.mountPath }}
       data_dir = {{ .Values.persistence.odoo.mountPath }}
       admin_passwd = {{ $admin.passwd }}
       longpolling_port = {{ .Values.service.longpolling.ports.longpolling.port }}
       xmlrpc = True
       xmlrpc_interface =
       xmlrpc_port = {{ .Values.service.main.ports.main.port }}
       xmlrpcs = True
       xmlrpcs_interface =
       xmlrpcs_port = {{ .Values.service.xmlrpcs.ports.xmlrpcs.port }}
       csv_internal_sep = ,
       db_maxconn = 64
       debug_mode = False
       limit_memory_hard = 2684354560
       limit_memory_soft = 2147483648
       limit_request = 8192
       limit_time_cpu = 60
       limit_time_real = 120
       list_db = True
       log_db = False
       log_handler = [':INFO']
       log_level = info
       logfile = None
       max_cron_threads = 2
       osv_memory_age_limit = 1.0
       osv_memory_count_limit = False
       smtp_server = {{ $smtp.server }}
       smtp_port = {{ $smtp.port }}
       smtp_user = {{ $smtp.user }}
       smtp_password = {{ $smtp.password }}
       smtp_ssl = {{ $smtp.ssl }}
       email_from = {{ $smtp.from }}
       workers = 0

{{- end -}}
