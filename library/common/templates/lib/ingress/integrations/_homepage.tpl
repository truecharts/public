{{- define "tc.v1.common.lib.ingress.integration.homepage" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $homepage := $objectData.integrations.homepage -}}
  {{- if and $homepage $homepage.enabled -}}
    {{- if not (hasKey $homepage "widget") -}}
      {{- $_ := set $objectData.integrations.homepage "widget" dict -}}
    {{- end -}}

    {{- $widEnabled := true -}}
    {{- if and (hasKey $homepage.widget "enabled") (kindIs "bool" $homepage.widget.enabled) -}}
      {{- $widEnabled = $homepage.widget.enabled -}}
    {{- end -}}

    {{- include "tc.v1.common.lib.ingress.integration.homepage.validation" (dict "objectData" $objectData) -}}

    {{- $name := $homepage.name | default ($rootCtx.Release.Name | camelcase) -}}
    {{- $desc := $homepage.description | default $rootCtx.Chart.Description -}}
    {{- $icon := $homepage.icon | default $rootCtx.Chart.Icon -}}
    {{- $defaultType := $rootCtx.Chart.Name | lower -}}
    {{/* Remove any non-characters from the default type */}}
    {{- $defaultType = regexReplaceAll "\\W+" $defaultType "" -}}
    {{- $type := $homepage.widget.type | default $defaultType -}}
    {{- $url := $homepage.widget.url -}}
    {{- $href := $homepage.href -}}

    {{- if not $href -}}
      {{- $fHost := $objectData.hosts | mustFirst -}}
      {{- $fPath := $fHost.paths | mustFirst -}}
      {{- $host := tpl $fHost.host $rootCtx -}}
      {{- $path := tpl $fPath.path $rootCtx -}}

      {{- $href = printf "https://%s/%s" $host ($path | trimPrefix "/") -}}
    {{- end -}}

    {{- if not $url -}}
      {{- $svc := $objectData.selectedService.name -}}
      {{- $port := $objectData.selectedService.port -}}
      {{- $prot := $objectData.selectedService.protocol -}}
      {{- $ns := include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Ingress") -}}

      {{- $url = printf "%s://%s.%s.svc:%s" $prot $svc $ns $port -}}
    {{- end -}}

    {{- $_ := set $objectData.annotations "gethomepage.dev/enabled" "true" -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/name" (tpl $name $rootCtx) -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/href" (tpl $href $rootCtx) -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/description" (tpl $desc $rootCtx) -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/icon" (tpl $icon $rootCtx) -}}
    {{- with $homepage.group -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/group" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $homepage.weight -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/weight" (. | toString) -}}
    {{- end -}}

    {{- $selector := printf "app.kubernetes.io/instance=%s,pod.lifecycle in (permanent)" $rootCtx.Release.Name -}}
    {{- with $homepage.podSelector -}}
      {{- $selector = (printf "pod.name in (%s),pod.lifecycle in (permanent)" (join "," .)) -}}
    {{- end -}}
    {{- $_ := set $objectData.annotations "gethomepage.dev/pod-selector" $selector -}}

    {{- if $widEnabled -}}
      {{- $_ := set $objectData.annotations "gethomepage.dev/widget.type" (tpl $type $rootCtx) -}}

      {{- with $url -}}
        {{- $_ := set $objectData.annotations "gethomepage.dev/widget.url" (tpl $url $rootCtx) -}}
      {{- end -}}

      {{- if $homepage.widget.custom -}}
        {{- range $k, $v := $homepage.widget.custom -}}
          {{- if $v -}}
            {{- $_ := set $objectData.annotations (printf "gethomepage.dev/widget.%s" $k) (tpl $v $rootCtx | toString) -}}
          {{- end -}}
        {{- end -}}
        {{- range $homepage.widget.customkv -}}
          {{- if .value -}}
            {{- $_ := set $objectData.annotations (printf "gethomepage.dev/widget.%s" .key ) (tpl .value $rootCtx | toString) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

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

  {{- if $homepage.widget.customkv -}}
    {{- if not (kindIs "slice" $homepage.widget.customkv) -}}
      {{- fail (printf "Ingress - Expected [integrations.homepage.widget.customkv] to be a [slice], but got [%s]" (kindOf $homepage.widget.customkv)) -}}
    {{- end -}}
    {{- range $item := $homepage.widget.customkv -}}
      {{- if not $item.key -}}
        {{- fail "Ingress - Expected non-empty [key] in [integrations.homepage.widget.customkv]" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
