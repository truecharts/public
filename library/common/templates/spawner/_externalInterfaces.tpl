{{- define "ix.v1.common.spawner.externalInterface" -}}
  {{/* Validate that data from externalInterfaces are correct before start creating objects */}}
  {{- range $iface := .Values.externalInterfaces -}}
    {{- include "ix.v1.common.externalInterface" (dict "iface" $iface) -}}
  {{- end -}}

  {{/* Now we are sure data is validated, spawn the objects */}}
  {{- range $index, $iface := .Values.ixExternalInterfacesConfiguration -}}
    {{- include "ix.v1.common.class.externalInterface" (dict "iface" $iface "index" $index "root" $) -}}
  {{- end -}}
{{- end -}}
