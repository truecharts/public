{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.gluetun" -}}
  {{- $glue := $.Values.addons.gluetun -}}
  {{- if $glue.enabled -}}
    {{- if not $glue.container.env -}}
      {{- $_ := set $glue.container "env" dict -}}
    {{- end -}}

    {{- $fw := $glue.container.env.FIREWALL -}}
    {{- if (eq $fw "on") -}}
      {{- $nets := $glue.container.env.FIREWALL_OUTBOUND_SUBNETS | default list -}}
      {{- if $nets -}}{{- $nets = $nets | splitList "," -}}{{- end -}}
      {{- $nets = mustAppend $nets $.Values.chartContext.podCIDR -}}
      {{- $nets = mustAppend $nets $.Values.chartContext.svcCIDR -}}

      {{- $cleanNets := list -}}
      {{- range $nets -}}{{- $cleanNets = mustAppend $cleanNets (. | nospace) -}}{{- end -}}
      {{- $nets = $cleanNets | mustUniq -}}
      {{- $_ := set $glue.container.env "FIREWALL_OUTBOUND_SUBNETS" (join "," $nets) -}}

      {{- $inputPorts := $glue.container.env.FIREWALL_INPUT_PORTS | default list -}}
      {{- if $inputPorts -}}{{- $inputPorts = $inputPorts | splitList "," -}}{{- end -}}
      {{- if and
        $.Values.service $.Values.service.main $.Values.service.main.ports
        $.Values.service.main.ports.main $.Values.service.main.ports.main.port
      -}}
        {{- $inputPorts = mustAppend $inputPorts ($.Values.service.main.ports.main.port | toString) -}}
      {{- end -}}
      {{- $cleanInputPorts := list -}}
      {{- range $inputPorts -}}{{- $cleanInputPorts = mustAppend $cleanInputPorts (. | nospace) -}}{{- end -}}
      {{- $inputPorts = $cleanInputPorts | mustUniq -}}
      {{- $_ := set $glue.container.env "FIREWALL_INPUT_PORTS" (join "," $inputPorts) -}}
    {{- end -}}

    {{- $targetSelector := list "main" -}}
    {{- if $glue.targetSelector -}}
      {{- $targetSelector = $glue.targetSelector -}}
    {{- end -}}

    {{/* Append the vpn container to the workloads */}}
    {{- range $targetSelector -}}
      {{- $workload := get $.Values.workload . -}}
      {{- $_ := set $workload.podSpec.containers "gluetun" $glue.container -}}
    {{- end -}}

    {{/* Mount secrets */}}
    {{- range $secName, $secValues := $glue.secret -}}
      {{- $secretName := printf "gluetun-%s" $secName -}}
      {{- if not $secValues.basePath -}}
        {{- fail (printf "Gluetun - Secret [%s] does not have basePath") -}}
      {{- end -}}
      {{- $_ := set $secValues "enabled" true -}}
      {{- $_ := set $.Values.secret $secretName $secValues -}}

      {{- $persistence := (dict
        "enabled" true "type" "secret" "objectName" $secretName "targetSelector" dict "items" list
      ) -}}
      {{- if $secValues.defaultMode -}}
        {{- $_ := set $persistence "defaultMode" $secValues.defaultMode -}}
      {{- end -}}

      {{- range $key, $val := $secValues.data -}}
        {{- $item := (dict "key" $key "path" $key) -}}
        {{- $_ := set $persistence "items" (mustAppend $persistence.items $item) -}}
      {{- end -}}

      {{- $selectorValue := (dict "gluetun" (dict "mountPath" $secValues.basePath)) -}}
      {{- range $targetSelector -}}
        {{- $_ := set $persistence.targetSelector . $selectorValue -}}
      {{- end -}}

      {{- $_ := set $.Values.persistence $secretName $persistence -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
