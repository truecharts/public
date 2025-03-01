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

    {{- $_ := set $glue.container.env "FIREWALL" (ternary "on" "off" $glue.killSwitch) -}}
    {{- if $glue.killSwitch -}}
      {{- $nets := list $.Values.chartContext.podCIDR $.Values.chartContext.svcCIDR -}}
      {{- range $glue.excludedNetworksIPv4 -}}
        {{- $nets = append $nets . -}}
      {{- end -}}
      {{- range $glue.excludedNetworksIPv6 -}}
        {{- $nets = append $nets . -}}
      {{- end -}}
      {{- $_ := set $glue.container.env "FIREWALL_OUTBOUND_SUBNETS" (join "," $nets) -}}

      {{- $inputPorts := list -}}
      {{- if and
        $.Values.service $.Values.service.main $.Values.service.main.ports
        $.Values.service.main.ports.main $.Values.service.main.ports.main.port
      -}}
        {{- $inputPorts = list $.Values.service.main.ports.main.port -}}
      {{- end -}}
      {{- $inputPorts = concat $inputPorts $glue.inputPorts | mustUniq }}
      {{- $_ := set $glue.container.env "FIREWALL_INPUT_PORTS" (join "," $inputPorts) -}}
    {{- end-}}

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
    {{- range $secret, $secretValues := $glue.secret -}}
      {{- if and $.Values.secret (get $.Values.secret $secret) -}}
        {{- fail "Gluetun - Secret [%s] already defined in the top level secret" $secret -}}
      {{- end -}}
      {{- $_ := set $.Values.secret $secret $secretValues -}}

      {{- $persistence := dict -}}
      {{- $_ := set $persistence "enabled" true -}}
      {{- $_ := set $persistence "targetSelector" dict -}}
      {{- $_ := set $persistence "type" "secret" -}}

      {{- $mountPath := printf "/etc/%s" $secret -}}
      {{- if $secretValues.mountPath -}}
        {{- $mountPath = $secretValues.mountPath -}}
      {{- end -}}

      {{- $selectorValue := (dict "gluetun" (dict "mountPath" $mountPath)) -}}
      {{- range $targetSelector -}}
        {{- $_ := set $persistence.targetSelector . $selectorValue -}}
      {{- end -}}

      {{- $_ := set $.Values.persistence (printf "gluetun-%s" $secret) $persistence -}}
    {{- end -}}

    {{- $dir := $.Values.persistence.gluetundir -}}
    {{- $_ := set $dir "targetSelector" dict -}}

    {{- $selectorValue := (dict "tailscale" (dict "mountPath" "/gluetun")) -}}
    {{- range $targetSelector -}}
      {{- $_ := set $dir.targetSelector . $selectorValue -}}
    {{- end -}}
    {{- $_ := set $.Values.persistence "gluetundir" $dir -}}
  {{- end -}}
{{- end -}}
