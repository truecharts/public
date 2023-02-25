{{/* Define the secret */}}
{{- define "adguardhomesync.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $ahs := .Values.adguardhomesync }}

{{/* TODO Replica list */}}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  ORIGIN_URL: {{ $ahs.origin_url | quote }}
  ORIGIN_USERNAME: {{ $ahs.origin_username | quote }}
  ORIGIN_PASSWORD: {{ $ahs.origin_password | quote }}
  ORIGIN_APIPATH: {{ $ahs.origin_api_path | quote }}
  CRON: {{ $ahs.cron | quote }}
  RUNONSTART: {{ $ahs.runonstart }}
  FEATURES_GENERALSETTINGS: {{ $ahs.feat_gen_settings }}
  FEATURES_QUERYLOGCONFIG: {{ $ahs.feat_query_log_config }}
  FEATURES_STATSCONFIG: {{ $ahs.feat_stats_config }}
  FEATURES_CLIENTSETTINGS: {{ $ahs.feat_client_settings }}
  FEATURES_SERVICES: {{ $ahs.feat_services }}
  FEATURES_FILTERS: {{ $ahs.feat_filters }}
  FEATURES_DHCP_SERVERCONFIG: {{ $ahs.feat_dhcp_server_config }}
  FEATURES_DHCP_STATICLEASES: {{ $ahs.feat_dhcp_static_leases }}
  FEATURES_DNS_SERVERCONFIG: {{ $ahs.feat_dns_server_config }}
  FEATURES_DNS_ACCESSLISTS: {{ $ahs.dns_access_lists }}
  FEATURES_DNS_REWRITES: {{ $ahs.feat_dns_rewrites }}
{{- end -}}
