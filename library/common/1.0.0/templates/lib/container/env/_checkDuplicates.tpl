{{- define "ix.v1.common.util.envCheckDupes" -}}
  {{- $root := .root -}}

  {{- range $kOut, $vOut := $root.Values.envsForDupeCheck -}}
    {{- range $kIn, $vIn := $root.Values.envsForDupeCheck -}}
      {{- if and (ne $vOut.source $vIn.source) (eq $vOut.key $vIn.key) -}}
        {{- range $container := $vOut.containers -}}
          {{- if (mustHas $container $vIn.containers) -}}
            {{- fail (printf "Environment Variable (%s) on container (%s) is set more than once. [to (%s) on (%s)] and [to (%s) on (%s)]" $vOut.key $container $vOut.value $vOut.source $vIn.value $vIn.source) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- include "ix.v1.common.util.cleanupEnvsForCheck" (dict "root" $root) -}}

  {{- if $root.Values.envsForDupeCheck -}} {{/* TODO: Remove when testing is done */}}
    {{- fail "Failed to cleanup <envsForDupeCheck> key." -}}
  {{- end -}}
{{- end -}}

{{/* Stores envs for dupe checking later */}}
{{- define "ix.v1.common.util.storeEnvsForDupeCheck" -}}
  {{- $root := .root -}}
  {{- $source := .source -}}
  {{- $containers := .containers -}}
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
    {{- $tmpList = mustAppend $tmpList (dict "key" $k "value" $v "source" $source "containers" $containers) -}}
  {{- end -}}
  {{- $_ := set $root.Values "envsForDupeCheck" $tmpList -}}
{{- end -}}

{{- define "ix.v1.common.util.storeEnvFromVarsForCheck" -}}
  {{- $root := .root -}}
  {{- $name := .name -}}
  {{- $container := .container -}}
  {{- $type := .type -}}

  {{- $dupes := $root.Values.envsForDupeCheck -}}
  {{- range $item := $dupes -}}
    {{- if eq $item.source (printf "%s-%s" (camelcase $type) $name) -}}
      {{- if not (mustHas $container $item.containers) -}}
        {{- $dupes = without $dupes $item -}}
        {{- $_ := set $item "containers" (mustAppend $item.containers $container) -}}
        {{- $dupes = mustAppend $dupes $item -}}
        {{- $_ := set $root.Values "envsForDupeCheck" $dupes -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.util.cleanupEnvsForCheck" -}}
  {{- $root := .root -}}

  {{- if hasKey $root.Values "envsForDupeCheck" -}}
    {{- $_ := unset $root.Values "envsForDupeCheck" -}}
  {{- end -}}
{{- end -}}
