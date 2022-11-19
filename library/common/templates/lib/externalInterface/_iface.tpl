{{- define "ix.v1.common.externalInterface" -}}
  {{- $iface := .iface -}}
  {{- if not $iface.hostInterface -}}
    {{- fail "<hostInterface> is required when configuring External Interfaces." -}}
  {{- end -}}
  {{- if not $iface.ipam.type -}}
    {{- fail (printf "<ipam.type> is required. Interface (%s)" $iface.hostInterface) -}}
  {{- else if not (mustHas $iface.ipam.type (list "static" "dhcp")) -}}
    {{- fail (printf "Invalid option for <ipam.type> (%s). Valid options are static and dhcp. Interface (%s)" $iface.ipam.type $iface.hostInterface) -}}
  {{- end -}}

  {{- if and (or $iface.staticIPConfigurations $iface.staticRoutes) (ne $iface.ipam.type "static") -}}
    {{- fail (printf "<staticIPConfigurations> and <staticRoutes> cannot be used with <ipam.type> of (%s). Interface (%s)" $iface.ipam.type $iface.hostInterface) -}}
  {{- end -}}

  {{- if eq $iface.ipam.type "static" -}}
    {{- if not $iface.staticIPConfigurations -}}
      {{- fail (printf "Static IP is required when <ipam.type> is static. Interface (%s)" $iface.hostInterface) -}}
    {{- end -}}
    {{- with $iface.staticRoutes -}}
      {{- range . -}}
        {{- if or (not .destination) (not .gateway) -}}
          {{- fail (printf "<destination> and <gateway> are required when <staticRoutes> are defined. Interface (%s)" $iface.hostInterface) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
