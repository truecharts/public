{{/* Define the configmap */}}
{{- define "odoo.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $admin := .Values.odoo.admin -}}
{{- $smtp := .Values.odoo.smtp -}}

{{- $mainPort := .Values.service.main.ports.main.port -}}
{{- $odooPath := .Values.persistence.odoo.targetSelector.main.main.mountPath -}}
{{- $addonsPath := .Values.persistence.addons.targetSelector.main.main.mountPath -}}

{{- $pgdb := .Values.cnpg.main.database -}}
{{- $pguser := .Values.cnpg.main.user -}}
{{- $pgpassword := .Values.cnpg.main.creds.password | trimAll "\"" -}}
{{- $pghost := .Values.cnpg.main.creds.host | trimAll "\"" -}}

{{/* xmlrpc* keys are deprecated and http* keys are used in their place */}}
  {{- $reservedKeys := (list  "data_dir" "addons_path" "http_enable" "http_interface"
                              "http_port"  "xmlrpc" "xmlrpc_port" "xmlrpc_interface"
                              "db_port" "db_host" "db_name" "db_user" "db_sslmode"
                              "db_password") -}}
{{- $userKeys := list -}}

odoo-config:
  enabled: true
  data:
    odoo.conf: |
     [options]
     ; Paths
     data_dir = {{ $odooPath }}
     addons_path = {{ $addonsPath }}
     ; Network Details
     http_enable = True
     http_port = {{ $mainPort }}
     ; Database Details
     db_port = 5432
     db_host = {{ $pghost }}
     db_name = {{ $pgdb }}
     db_user = {{ $pguser }}
     db_sslmode = disable
     db_password = {{ $pgpassword }}
    {{- range $opt := .Values.odoo.additionalConf -}}
        {{- if (mustHas $opt.key $reservedKeys) -}}
          {{- fail (printf "Odoo - Key [%v] is not allowed to be modified") -}}
        {{- end -}}
        {{- $userKeys = mustAppend $userKeys $opt.key -}}
        {{- printf "%s = %s" $opt.key $opt.value | nindent 8 -}}
      {{- end -}}
{{- if not (deepEqual $userKeys (uniq $userKeys)) -}}
  {{- fail (printf "Odoo - Additional configuration keys must be unique, but got [%v]" (join ", " $userKeys)) -}}
{{- end -}}
{{- end -}}
