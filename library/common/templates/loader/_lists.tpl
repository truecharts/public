{{- define "tc.v1.common.loader.lists" -}}

  {{- include "tc.v1.common.values.persistenceList" . -}}

  {{- include "tc.v1.common.values.deviceList" . -}}

  {{- include "tc.v1.common.values.serviceList" . -}}

{{- end -}}
