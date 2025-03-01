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
      {{- $nets := $glue.container.env.FIREWALL_OUTBOUT_SUBNETS | splitList "," -}}
      {{- $nets = mustAppend ($nets $.Values.chartContext.podCIDR $.Values.chartContext.svcCIDR) | mustUniq -}}
      {{- $_ := set $glue.container.env "FIREWALL_OUTBOUND_SUBNETS" (join "," $nets) -}}

      {{- $inputPorts := $glue.container.env.FIREWALL_INPUT_PORTS | splitList "," -}}
      {{- if and
        $.Values.service $.Values.service.main $.Values.service.main.ports
        $.Values.service.main.ports.main $.Values.service.main.ports.main.port
      -}}
        {{- $inputPorts = mustAppend $inputPorts $.Values.service.main.ports.main.port -}}
      {{- end -}}
      {{- $inputPorts = $inputPorts | mustUniq -}}
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
      {{- $sec := (dict "enabled" true "data" $secValues.data) -}}
      {{- $_ := set $.Values.secret $secretName $sec -}}

      {{- $persistence := (dict
        "enabled" true "type" "secret" "objectName" $secretName "targetSelector" dict "items" list
      ) -}}
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

    {{- $dir := $.Values.persistence.gluetundir -}}
    {{- $_ := set $dir "targetSelector" dict -}}

    {{- $selectorValue := (dict "gluetun" (dict "mountPath" "/gluetun")) -}}
    {{- range $targetSelector -}}
      {{- $_ := set $dir.targetSelector . $selectorValue -}}
    {{- end -}}
    {{- $_ := set $.Values.persistence "gluetundir" $dir -}}
  {{- end -}}
{{- end -}}
