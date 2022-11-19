{{- define "ix.v1.common.class.serivce.externalName.spec" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}
type: ExternalName
externalName: {{ required "<externalName> is required when service type is set to ExternalName" $svcValues.externalName }}
  {{- include "ix.v1.common.class.serivce.clusterIP" (dict "svc" $svcValues) | indent 0 -}}
  {{- include "ix.v1.common.class.serivce.externalTrafficPolicy" (dict "svc" $svcValues "root" $root) | indent 0 -}}
{{- end -}}
