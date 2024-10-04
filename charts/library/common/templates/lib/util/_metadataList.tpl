{{- define "tc.v1.common.lib.util.metaListToDict" -}}
  {{- $objectData := .objectData -}}
  {{- $annoList := $objectData.annotationsList -}}
  {{- $labelList := $objectData.labelsList -}}

  {{- if not $objectData.annotations -}}
    {{- $_ := set $objectData "annotations" dict -}}
  {{- end -}}
  {{- if not $objectData.labels -}}
    {{- $_ := set $objectData "labels" dict -}}
  {{- end -}}

  {{- range $a := $annoList -}}
    {{- $_ := set $objectData.annotations $a.name $a.value -}}
  {{- end -}}

  {{- range $l := $labelList -}}
    {{- $_ := set $objectData.labels $l.name $l.value -}}
  {{- end -}}
{{- end -}}
