{{/* Define the configmap */}}
{{- define "pialert.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  pialert.conf: |
    # General
    TIMEZONE={{ .Values.TZ | squote }}
    PIALERT_WEB_PROTECTION={{ ternary "True" "False" .Values.pialert.general.web_protection }}
    {{- if .Values.pialert.general.web_protection }}
    PIALERT_WEB_PASSWORD={{ .Values.pialert.general.web_password | squote }}
    {{- end }}
    PRINT_LOG={{ ternary "True" "False" .Values.pialert.general.print_log }}
    REPORT_DASHBOARD_URL={{ .Values.pialert.general.report_dashboard_url | squote }}
    DAYS_TO_KEEP_EVENTS={{ .Values.pialert.general.days_to_keep_events }}
    SCAN_CYCLE_MINUTES={{ .Values.pialert.general.scan_cycle_minutes }}
    {{- with .Values.pialert.general.included_sections }}
    INCLUDED_SECTIONS=[
      {{- range $section := initial . }}
        {{ . | squote }},
      {{- end -}}
      {{ last . | squote }}
    ]
    {{- else }}
    INCLUDED_SECTIONS=['internet','new_devices','down_devices','events']
    {{- end }}
    # TODO:
    # Scan using interface eth0
    # SCAN_SUBNETS    = ['192.168.1.0/24 --interface=eth0']
    #
    # Scan multiple interfaces (eth1 and eth0):
    # SCAN_SUBNETS    = [ '192.168.1.0/24 --interface=eth1', '192.168.1.0/24 --interface=eth0' ]
    SCAN_SUBNETS=['192.168.1.0/24 --interface=eth1']


    # PUSHSAFER
    REPORT_PUSHSAFER={{ ternary "True" "False" .Values.pialert.pushsafer.enabled }}
    {{- if .Values.pialert.pushsafer.enabled }}
    PUSHSAFER_TOKEN={{ .Values.pialert.pushsafer.token | squote }}
    {{- end }}


    # Apprise
    REPORT_APPRISE={{ ternary "True" "False" .Values.pialert.apprise.enabled }}
    {{- if .Values.pialert.apprise.enabled }}
    APPRISE_HOST={{ .Values.pialert.apprise.host | squote }}
    APPRISE_URL={{ .Values.pialert.apprise.url | squote }}
    {{- end }}


    # NTFY
    REPORT_NTFY={{ ternary "True" "False" .Values.pialert.ntfy.enabled }}
    {{- if .Values.pialert.ntfy.enabled }}
    NTFY_HOST={{ .Values.pialert.ntfy.host | squote }}
    NTFY_TOPIC={{ .Values.pialert.ntfy.topic | squote }}
    NTFY_USER={{ .Values.pialert.ntfy.user | squote }}
    NTFY_PASSWORD={{ .Values.pialert.ntfy.password | squote }}
    {{- end }}


    # Webhooks
    REPORT_WEBHOOK={{ ternary "True" "False" .Values.pialert.webhook.enabled }}
    {{- if .Values.pialert.webhook.enabled }}
    WEBHOOK_URL={{ .Values.pialert.webhook.url | squote }}
    WEBHOOK_PAYLOAD={{ .Values.pialert.webhook.payload | squote }}
    WEBHOOK_REQUEST_METHOD={{ .Values.pialert.webhook.method | squote }}
    {{- end }}


    # Email
    REPORT_MAIL={{ ternary "True" "False" .Values.pialert.email.enabled }}
    {{- if .Values.pialert.email.enabled }}
    SMTP_SERVER='smtp.gmail.com'
    SMTP_PORT=587
    REPORT_TO='user@gmail.com'
    REPORT_FROM='Pi.Alert <user@gmail.com>'
    SMTP_SKIP_LOGIN=False
    SMTP_USER='user@gmail.com'
    SMTP_PASS='password'
    SMTP_SKIP_TLS=False
    {{- end }}


    # MQTT
    #---------------------------
    REPORT_MQTT=False
    MQTT_BROKER='192.168.1.2'
    MQTT_PORT=1883
    MQTT_USER='mqtt'
    MQTT_PASSWORD='passw0rd'
    MQTT_QOS=0
    MQTT_DELAY_SEC=2

    # DynDNS
    #---------------------------
    DDNS_ACTIVE=False
    DDNS_DOMAIN='your_domain.freeddns.org'
    DDNS_USER='dynu_user'
    DDNS_PASSWORD='A0000000B0000000C0000000D0000000'
    DDNS_UPDATE_URL='https://api.dynu.com/nic/update?'


    # PiHole
    #---------------------------
    # if enabled you need to map '/etc/pihole/pihole-FTL.db' in docker-compose.yml
    PIHOLE_ACTIVE=False
    # if enabled you need to map '/etc/pihole/dhcp.leases' in docker-compose.yml
    DHCP_ACTIVE=False


    # Pholus
    #---------------------------
    PHOLUS_ACTIVE=False
    PHOLUS_TIMEOUT=20
    PHOLUS_FORCE=False
    PHOLUS_DAYS_DATA=7
    PHOLUS_RUN='once'
    PHOLUS_RUN_TIMEOUT=300
    PHOLUS_RUN_SCHD='0 4 * * *'


    #-------------------IMPORTANT INFO-------------------#
    #   This file is ingested by a python script, so if  #
    #        modified it needs to use python syntax      #
    #-------------------IMPORTANT INFO-------------------#
{{- end }}
