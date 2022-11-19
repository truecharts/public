{{- define "ix.v1.common.lib.values.persistenceList" -}}
  {{- $root := . -}}

  {{/* Go over the persistence list */}}
  {{- range $index, $persistence := $root.Values.persistenceList -}}
    {{/* Generate the name */}}
    {{- $name := (printf "persist-list-%s" (toString $index)) -}}

    {{- with $persistence.name -}}
      {{- $name = . -}}
    {{- end -}}

    {{/* Make sure a persistence dict exists before trying to add items */}}
    {{- if not (hasKey $root.Values "persistence") -}}
      {{- $_ := set $root.Values "persistence" dict -}}
    {{- end -}}

    {{/* Add the device as a persistence dict,
    other templates will take care of the
    volume and volumeMounts */}}
    {{- $_ := set $root.Values.persistence $name $persistence -}}
  {{- end -}}
{{- end -}}
