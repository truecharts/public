{{- define "ix.v1.common.class.serivce.nodePort.spec" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}
type: NodePort
  {{- include "ix.v1.common.class.serivce.clusterIP" (dict "svc" $svcValues) | indent 0 -}}
  {{- include "ix.v1.common.class.serivce.ipFamily" (dict "svc" $svcValues "root" $root) | indent 0 -}}
  {{- include "ix.v1.common.class.serivce.externalTrafficPolicy" (dict "svc" $svcValues "root" $root) | indent 0 -}}
{{- end -}}
