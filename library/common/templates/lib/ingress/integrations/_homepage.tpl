{{- define "tc.v1.common.lib.ingress.integration.homepage" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $homepage := $objectData.integrations.homepage -}}
  {{- if and $homepage $homepage.enabled -}}
    {{- if not (hasKey $homepage "widget") -}}
      {{- $_ := set $objectData.integrations.homepage "widget" dict -}}
    {{- end -}}

    {{- include "tc.v1.common.lib.ingress.integration.homepage.validation" (dict "objectData" $objectData) -}}

    {{- $name := $homepage.name | default ($rootCtx.Chart.Name | camelcase) -}}
    {{- $desc := $homepage.description | default $rootCtx.Chart.Description -}}
    {{- $icon := $homepage.icon | default $rootCtx.Chart.Icon -}}
    {{- $type := $homepage.widget.type | default $rootCtx.Chart.Name -}}
    {{- $url := $homepage.widget.url -}}

    {{- if not $url -}}
      {{- $fHost := $objectData.hosts | mustFirst -}}
      {{- $fPath := $fHost.paths | mustFirst -}}
      {{- $host := tpl $fHost.host $rootCtx -}}
      {{- $path := tpl $fPath.path $rootCtx -}}

      {{- $url = printf "https://%s/%s" $host ($path | trimPrefix "/") -}}
    {{- end -}}

    {{- $_ := set $objectData.annotations "gethomepage.dev/enabled" "true" -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/name" (tpl $name $rootCtx) -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/description" (tpl $desc $rootCtx) -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/icon" (tpl $icon $rootCtx) -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/widget.type" (tpl $type $rootCtx) -}}
    {{- with $homepage.group -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/group" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $homepage.weight -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/weight" (. | toString) -}}
    {{- end -}}

    {{- with $url -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/widget.url" (tpl $url $rootCtx) -}}
    {{- end -}}

    {{- if $homepage.widget.custom -}}
      {{- range $k, $v := $homepage.widget.custom -}}
        {{- $_ := set $objectData.annotations (printf "gethomepage.dev/widget.%s" $k) (tpl $v $rootCtx | toString) -}}
      {{- end -}}
    {{- end -}}

    {{- with $homepage.podSelector -}}
      {{- $selector := (printf "pod.name in (%s)" (join "," .)) -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/pod-selector" $selector -}}
    {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.ingress.integration.homepage.validation" -}}
  {{- $objectData := .objectData -}}

  {{- $homepage := $objectData.integrations.homepage -}}

  {{- with $homepage.podSelector -}}
    {{- if not (kindIs "slice" .) -}}
      {{- fail (printf "Ingress - Expected [integrations.homepage.podSelector] to be a [slice], but got [%s]" (kindOf .)) -}}
    {{- end -}}
  {{- end -}}

  {{- if $homepage.widget.custom -}}
    {{- if not (kindIs "map" $homepage.widget.custom) -}}
      {{- fail (printf "Ingress - Expected [integrations.homepage.widget.custom] to be a [map], but got [%s]" (kindOf $homepage.widget.custom)) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
