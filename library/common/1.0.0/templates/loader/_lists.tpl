{{- define "ix.v1.common.loader.lists" -}}

  {{- include "ix.v1.common.lib.values.persistenceList" . -}}

  {{- include "ix.v1.common.lib.values.deviceList" . -}}

  {{- include "ix.v1.common.lib.values.serviceList" . -}}

{{- end -}}
