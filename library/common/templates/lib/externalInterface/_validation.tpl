{{/* External Interface Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.externalInterface.validation" (dict "objectData" $objectData) -}}
objectData: The object data to validate that contains the external interface configuratioon.
*/}}

{{- define "tc.v1.common.lib.externalInterface.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if and $objectData.targetSelector (not (kindIs "slice" $objectData.targetSelector)) -}}
    {{- fail (printf "External Interface - Expected <targetSelector> to be a [list], but got [%s]" (kindOf $objectData.targetSelector)) -}}
  {{- end -}}

  {{- if not $objectData.hostInterface -}}
    {{- fail "External Interface - Expected non-empty <hostInterface>" -}}
  {{- end -}}

  {{- if not $objectData.ipam -}}
    {{- fail "External Interface - Expected non-empty <ipam>" -}}
  {{- end -}}

  {{- if not $objectData.ipam.type -}}
    {{- fail "External Interface - Expected non-empty <ipam.type>" -}}
  {{- end -}}

  {{- $types := (list "dhcp" "static") -}}
  {{- if not (mustHas $objectData.ipam.type $types) -}}
    {{- fail (printf "External Interface - Expected <ipam.type> to be one of [%s], but got [%s]" (join ", " $types) $objectData.ipam.type) -}}
  {{- end -}}

  {{- if and (or $objectData.ipam.staticIPConfigurations $objectData.ipam.staticRoutes) (ne $objectData.ipam.type "static") -}}
    {{- fail "External Interface - Expected empty <ipam.staticIPConfigurations> and <ipam.staticRoutes> when <ipam.type> is not [static]" -}}
  {{- end -}}

  {{- if eq $objectData.ipam.type "static" -}}
    {{- if not $objectData.ipam.staticIPConfigurations -}}
      {{- fail "External Interface - Expected non-empty <ipam.staticIPConfigurations> when <ipam.type> is [static]" -}}
    {{- end -}}

    {{- with $objectData.ipam.staticRoutes -}}
      {{- range . -}}
        {{- if not .destination -}}
          {{- fail "External Interface - Expected non-empty <destination> in <ipam.staticRoutes>" -}}
        {{- end -}}

        {{- if not .gateway -}}
          {{- fail "External Interface - Expected non-empty <gateway> in <ipam.staticRoutes>" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
