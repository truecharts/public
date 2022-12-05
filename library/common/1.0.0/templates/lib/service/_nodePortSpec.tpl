{{- define "ix.v1.common.class.serivce.nodePort.spec" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root }}
type: NodePort
  {{- include "ix.v1.common.class.serivce.clusterIP" (dict "svc" $svcValues) | trim | nindent 0 -}}
  {{- include "ix.v1.common.class.serivce.ipFamily" (dict "svc" $svcValues "root" $root) | trim | nindent 0 -}}
  {{- include "ix.v1.common.class.serivce.externalTrafficPolicy" (dict "svc" $svcValues "root" $root) | trim | nindent 0 -}}
{{- end -}}
