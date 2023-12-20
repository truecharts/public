{{/* Define the configmap */}}
{{- define "pialert.secret" -}}

{{- $secretName := (printf "%s-pialert-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

enabled: true
data:
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
    {{- with (uniq .Values.pialert.general.included_sections) }}
      {{- if gt (len .) 4 -}}
        {{- fail "You can define up to 4 unique sections" -}}
      {{- end }}
    INCLUDED_SECTIONS=[
      {{- range $section := initial . }}
        {{ . | squote }},
      {{- end }}
      {{ last . | squote }}
    ]
    {{- else }}
    INCLUDED_SECTIONS=['internet','new_devices','down_devices','events']
    {{- end }}
    {{- with .Values.pialert.general.scan_subnets }}
    SCAN_SUBNETS=[
      {{- range $entry := initial . }}
        {{ (printf "%s --interface=%s" .cidr .interface) | squote }},
      {{- end }}
      {{- with last . }}
        {{ (printf "%s --interface=%s" .cidr .interface) | squote }}
      {{- end }}
    ]
    {{- end }}


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
    SMTP_SERVER={{ .Values.pialert.email.server | squote }}
    SMTP_PORT={{ .Values.pialert.email.port }}
    REPORT_TO={{ .Values.pialert.email.report_to | squote }}
    REPORT_FROM={{ .Values.pialert.email.report_from | squote }}
    SMTP_SKIP_LOGIN={{ ternary "True" "False" .Values.pialert.email.skip_login }}
    {{- with .Values.pialert.email.user }}
    SMTP_USER={{ . | squote }}
    {{- end }}
    {{- with .Values.pialert.email.password }}
    SMTP_PASS={{ . | squote }}
    {{- end }}
    SMTP_SKIP_TLS={{ ternary "True" "False" .Values.pialert.email.skip_tls }}
    {{- end }}


    # MQTT
    REPORT_MQTT={{ ternary "True" "False" .Values.pialert.mqtt.enabled }}
    {{- if .Values.pialert.mqtt.enabled }}
    MQTT_BROKER={{ .Values.pialert.mqtt.broker | squote }}
    MQTT_PORT={{ .Values.pialert.mqtt.port }}
    {{- with .Values.pialert.mqtt.user }}
    MQTT_USER={{ . | squote }}
    {{- end }}
    {{- with .Values.pialert.mqtt.password }}
    MQTT_PASSWORD={{ . | squote }}
    {{- end }}
    MQTT_QOS={{ .Values.pialert.mqtt.qos }}
    MQTT_DELAY_SEC={{ .Values.pialert.mqtt.delay_sec }}
    {{- end }}


    # DynDNS
    DDNS_ACTIVE={{ ternary "True" "False" .Values.pialert.dyndns.enabled }}
    {{- if .Values.pialert.dyndns.enabled }}
    DDNS_DOMAIN={{ .Values.pialert.dyndns.domain | squote }}
    {{- with .Values.pialert.dyndns.user }}
    DDNS_USER={{ . | squote }}
    {{- end }}
    {{- with .Values.pialert.dyndns.password }}
    DDNS_PASSWORD={{ . | squote }}
    {{- end }}
    DDNS_UPDATE_URL={{ .Values.pialert.dyndns.update_url | squote }}
    {{- end }}


    # Pholus
    PHOLUS_ACTIVE={{ ternary "True" "False" .Values.pialert.pholus.enabled }}
    {{- if .Values.pialert.pholus.enabled }}
    PHOLUS_TIMEOUT={{ .Values.pialert.pholus.timeout }}
    PHOLUS_FORCE={{ ternary "True" "False" .Values.pialert.pholus.force }}
    PHOLUS_DAYS_DATA={{ .Values.pialert.pholus.days_data }}
    PHOLUS_RUN={{ .Values.pialert.pholus.run | squote }}
    PHOLUS_RUN_TIMEOUT={{ .Values.pialert.pholus.run_timeout }}
    PHOLUS_RUN_SCHD={{ .Values.pialert.pholus.run_schedule | squote }}
    {{- end }}


    # PiHole
    PIHOLE_ACTIVE={{ ternary "True" "False" .Values.pialert.pihole.pihole_active }}
    DHCP_ACTIVE={{ ternary "True" "False" .Values.pialert.pihole.dhcp_active }}
{{- end }}
