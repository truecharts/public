{{/* Volume Mounts included by the container. */}}
{{- define "ix.v1.common.container.volumeMounts" -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $root := .root -}}
  {{- $extraContainerVolMounts := .extraContainerVolMounts -}}

  {{- if $isMainContainer -}}
    {{- range $name, $item := $root.Values.persistence -}}
      {{- if $item.enabled -}}
        {{- if not $item.noMount -}}
          {{- include "ix.v1.common.container.volumeMount"  (dict "root" $root
                                                                  "item" $item
                                                                  "name" $name) | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

    {{/* TODO: write tests when statefulset is ready */}}
    {{- if eq $root.Values.controller.type "statefulset" -}}
      {{- range $index, $vct := $root.Values.volumeClaimTemplates -}}
        {{- include "ix.v1.common.container.volumeMount"  (dict "root" $root
                                                                "item" $vct
                                                                "name" (toString $index)) | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- else if not $isMainContainer -}}
    {{/* Create a list of volume names, so we can run checks against it */}}
    {{- $volNames := list -}}
    {{- range $name, $item := $root.Values.persistence -}}
      {{- $volNames = mustAppend $volNames $name -}}
    {{- end -}}
    {{- range $index, $volMount := $extraContainerVolMounts }}
      {{- if not $volMount.name -}}
        {{- fail "<name> is required in volumeMounts in init/system/install/upgrade/additional containers." -}}
      {{- end -}}

      {{- if not (mustHas $volMount.name $volNames) -}}
        {{- fail (printf "You are trying to mount a volume that does not exist (%s). Please define the volume in <persistence>." $volMount.name) -}}
      {{- end -}}

      {{- $item := dict -}}

      {{- $_ := set $item "mountPath" $volMount.mountPath -}}
      {{- if hasKey $volMount "subPath" -}}
        {{- $_ := set $item "subPath" $volMount.subPath -}}
      {{- end -}}
      {{- if hasKey $volMount "mountPropagation" -}}
        {{- $_ := set $item "mountPropagation" $volMount.mountPropagation -}}
      {{- end -}}
      {{- if hasKey $volMount "readOnly" -}}
        {{- $_ := set $item "readOnly" $volMount.readOnly -}}
      {{- end -}}

      {{- include "ix.v1.common.container.volumeMount" (dict "root" $root
                                                              "item" $item
                                                              "name" $volMount.name) | nindent 0 -}}
    {{- end }}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.container.volumeMount" -}}
  {{- $root := .root -}}
  {{- $item := .item -}}
  {{- $name := .name -}}
  {{- if not $item.mountPath -}} {{/* Make sure that we have a mountPath */}}
    {{- fail "<mountPath> must be defined, alternatively use the <noMount> flag." -}}
  {{- end -}}
  {{- $mountPath := (tpl $item.mountPath $root) -}}
  {{- if not (hasPrefix "/" $mountPath) -}}
    {{- fail (printf "Mount path (%s), must start with a forward slash -> / <-" $mountPath) -}}
  {{- end }}
- name: {{ tpl $name $root }}
  mountPath: {{ $mountPath }}
  {{- with $item.subPath }}
  subPath: {{ tpl . $root }}
  {{- end -}}
  {{- if (hasKey $item "readOnly") -}}
    {{- if or (eq $item.readOnly true) (eq $item.readOnly false) }}
  readOnly: {{ $item.readOnly }}
    {{- else -}}
      {{- fail (printf "<readOnly> cannot be empty on item (%s)" $name) -}}
    {{- end -}}
  {{- end -}}
  {{- with $item.mountPropagation }}
  mountPropagation: {{ tpl . $root }}
  {{- end -}}
{{- end -}}
