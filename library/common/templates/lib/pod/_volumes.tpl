
{{/* Volumes included by the controller. */}}
{{- define "ix.v1.common.controller.volumes" -}}
  {{- $root := .root -}}
  {{- $persistence := .persistence -}}
  {{- $persistenceDefault := $root.Values.global.defaults.persistenceType -}}

  {{- range $index, $persistence := $persistence -}}
    {{- if $persistence.enabled -}}
      {{- if not $persistence.type -}} {{/* If persistence type is not defined, fallback to $persistenceDefault */}}
        {{- $_ := set $persistence "type" $persistenceDefault -}}
      {{- end -}}
      {{- if eq $persistence.type "pvc" -}} {{/* PVC */}}
        {{- include "ix.v1.common.controller.volumes.pvc" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "emptyDir" -}} {{/* emptyDir */}}
        {{- include "ix.v1.common.controller.volumes.emptyDir" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "configMap" -}} {{/* configMap */}}
        {{- include "ix.v1.common.controller.volumes.configMap" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "secret" -}} {{/* secret */}}
        {{- include "ix.v1.common.controller.volumes.secret" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "hostPath" -}} {{/* hostPath */}}
        {{- include "ix.v1.common.controller.volumes.hostPath" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "nfs" -}} {{/* NFS */}}
        {{- include "ix.v1.common.controller.volumes.nfs" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "ixVolume" -}} {{/* ix-volumes */}}
        {{- include "ix.v1.common.controller.volumes.ixVols" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else if eq $persistence.type "custom" -}} {{/* Custom, in case we want to add something once */}}
        {{- include "ix.v1.common.controller.volumes.custom" (dict "index" $index "volume" $persistence "root" $root) -}}
      {{- else -}}
        {{- fail (printf "Not a valid persistence.type (%s)" $persistence.type) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
