{{- define "tc.v1.common.loader.init" -}}
  {{- include "tc.v1.common.lib.util.manifest.manage" . | nindent 0 -}}

  {{/* Autogenerate postgresql passwords if needed */}}
  {{- include "tc.v1.common.spawner.cnpg" . }}

  {{/* Autogenerate redis passwords if needed */}}
  {{- include "tc.v1.common.dependencies.redis.injector" . }}

  {{/* Autogenerate mariadb passwords if needed */}}
  {{- include "tc.v1.common.dependencies.mariadb.injector" . }}

  {{/* Autogenerate mongodb passwords if needed */}}
  {{- include "tc.v1.common.dependencies.mongodb.injector" . }}

  {{/* Autogenerate clickhouse passwords if needed */}}
  {{- include "tc.v1.common.dependencies.clickhouse.injector" . }}

  {{/* Autogenerate solr passwords if needed */}}
  {{- include "tc.v1.common.dependencies.solr.injector" . }}

  {{/* Enable code-server add-on if required */}}
  {{- if .Values.addons.codeserver.enabled }}
    {{- include "tc.v1.common.addon.codeserver" . }}
  {{- end -}}

  {{/* Enable VPN add-on if required */}}
  {{- if ne "disabled" .Values.addons.vpn.type -}}
    {{- include "tc.v1.common.addon.vpn" . }}
  {{- end -}}
{{- end -}}
