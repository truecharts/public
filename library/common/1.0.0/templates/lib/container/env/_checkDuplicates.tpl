{{- define "ix.v1.common.util.envCheckDupes" -}}
  {{- $root := .root -}}

  {{- range $kOut, $vOut := $root.Values.envsForDupeCheck -}}
    {{- range $kIn, $vIn := $root.Values.envsForDupeCheck -}}
      {{- if and (eq $vOut.key $vIn.key) (ne $vOut.source $vIn.source) -}}
        {{- fail (printf "Environment Variable (%s) is already set [to (%s) on (%s)] and [to (%s) on (%s)]" $vOut.key $vOut.value $vOut.source $vIn.value $vIn.source) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* Stores envs for dupe checking later */}}
{{- define "ix.v1.common.util.storeEnvsForCheck" -}}
  {{- $root := .root -}}
  {{- $source := .source -}}
  {{- $data := .data -}}

  {{/* If there is no key already, create it now */}}
  {{- if not (hasKey $root.Values "envsForDupeCheck") -}}
    {{- $_ := set $root.Values "envsForDupeCheck" list -}}
  {{- end -}}

  {{/* Lists are passed as stringified arrays, convert them to a real list */}}
  {{- if or (eq $source "fixedEnv") -}}
    {{- $data = $data | fromJsonArray -}}
  {{- end -}}

  {{- $tmpList := $root.Values.envsForDupeCheck -}}
  {{- range $k, $v := $data -}}
    {{- if kindIs "map" $v -}}
      {{- $k = $v.name -}}
      {{- $v = $v.value -}}
    {{- end -}}
    {{- $tmpList = mustAppend $tmpList (dict "key" $k "value" $v "source" $source) -}}
  {{- end -}}
  {{- $_ := set $root.Values "envsForDupeCheck" $tmpList -}}
{{- end -}}

{{- define "ix.v1.common.util.cleanupEnvsForCheck" -}}
  {{- $root := .root -}}

  {{- if hasKey $root.Values "envsForDupeCheck" -}}
    {{- $_ := unset $root.Values "envsForDupeCheck" -}}
  {{- end -}}
{{- end -}}
