{{/* Returns Persitent Volume Claim name*/}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.pvc.name" (dict "rootCtx" $ "objectName" $objectName "objectData" $objectData) }}
objectName: the base name of the object without any alteration or sanitation
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.storage.pvc.name" -}}
{{- $rootCtx := .rootCtx -}}
{{- $objectName := .objectName -}}
{{- $objectData := .objectData -}}
{{- $hashValues := "" -}}

  {{- $renderedName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $objectName) -}}
  {{/* Perform validations */}}
  {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $renderedName) -}}

  {{- $modes := (list "smb" "nfs") -}}
  {{- if $objectData.static -}}
    {{- if and $objectData.static.mode (mustHas $objectData.static.mode $modes) -}}

      {{- $size := $objectData.size | default $rootCtx.Values.global.fallbackDefaults.pvcSize -}}

      {{/* Create a unique name taking into account server and share,
          without this, changing one of those values is not possible */}}

      {{- $hashValues = (printf "%s-%s-%s" $size $objectData.static.server $objectData.static.share) -}}
      {{- if $objectData.domain -}}
        {{- $hashValues = (printf "%s-%s" $hashValues $objectData.domain) -}}
      {{- end -}}

    {{- else if eq $objectData.static.mode "custom" -}}
      {{- $hashValues = (printf "%s-%v" $size $objectData.csi) -}}
    {{- end -}}
  {{- end -}}

  {{/* Create a hash from the dataSource settings to ensure a new PVC is created when a dataSource is set*/}}
  {{- if $objectData.dataSource -}}
    {{- $hashValues = (printf "%s-%s-%s" $hashValues $objectData.dataSource.kind $objectData.dataSource.name) -}}
  {{- end -}}

  {{- $objectName = $renderedName -}}
  {{- if $hashValues -}}
    {{- $hash := adler32sum $hashValues -}}
    {{- $objectName = (printf "%s-%v" $renderedName $hash) -}}
  {{- end -}}

  {{/* Return the new objectName */}}
  {{- $objectName -}}

{{- end -}}
