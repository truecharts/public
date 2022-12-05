{{- define "ix.v1.common.spawner.externalInterface" -}}
  {{/* Validate that data from externalInterfaces are correct before start creating objects */}}
  {{- range .Values.externalInterfaces -}}
    {{- include "ix.v1.common.externalInterface.validate" (dict "iface" .) -}}
  {{- end -}}
  {{- range $index, $iface := .Values.ixExternalInterfacesConfiguration -}}
    {{- include "ix.v1.common.class.externalInterface" (dict "iface" $iface "index" $index "root" $) -}}
  {{- end -}}
{{- end -}}
