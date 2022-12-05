{{- define "ix.v1.common.class.serivce.clusterIP.spec" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root }}
type: ClusterIP
  {{- include "ix.v1.common.class.serivce.clusterIP" (dict "svc" $svcValues) | trim | nindent 0 -}}
  {{- include "ix.v1.common.class.serivce.ipFamily" (dict "svc" $svcValues "root" $root) | trim | nindent 0 -}}
{{- end -}}
