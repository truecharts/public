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

  {{- if and (or $objectData.staticIPConfigurations $objectData.staticRoutes) (ne $objectData.ipam.type "static") -}}
    {{- fail "External Interface - Expected empty <staticIPConfigurations> and <staticRoutes> when <ipam.type> is not [static]" -}}
  {{- end -}}

  {{- if eq $objectData.ipam.type "static" -}}
    {{- if not $objectData.staticIPConfigurations -}}
      {{- fail "External Interface - Expected non-empty <staticIPConfigurations> when <ipam.type> is [static]" -}}
    {{- end -}}

    {{- with $objectData.staticRoutes -}}
      {{- range . -}}
        {{- if not .destination -}}
          {{- fail "External Interface - Expected non-empty <destination> in <staticRoutes>" -}}
        {{- end -}}

        {{- if not .gateway -}}
          {{- fail "External Interface - Expected non-empty <gateway> in <staticRoutes>" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
