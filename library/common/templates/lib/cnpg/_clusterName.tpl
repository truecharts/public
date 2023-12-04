{{- define "tc.v1.common.lib.cnpg.clusterName" -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.version -}}
    {{- $_ := set $objectData "version" "legacy" -}}
  {{- end -}}

  {{- $clusterName := $objectData.name -}}
  {{/* Append version to the cluster name if available */}}
  {{- if ne $objectData.version "legacy" -}}
    {{- $clusterName = printf "%s-%v" $objectData.name $objectData.version -}}
  {{- end -}}

  {{/* Append the recovery string to the cluster name if available */}}
  {{- if $objectData.recValue -}}
    {{- $clusterName = printf "%s-%s" $clusterName $objectData.recValue -}}
  {{- end -}}

  {{- $clusterName -}}
{{- end -}}
