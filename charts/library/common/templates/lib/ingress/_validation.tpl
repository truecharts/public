{{/* Ingress Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.ingress.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The Ingress object.
*/}}

{{- define "tc.v1.common.lib.ingress.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if $objectData.targetSelector -}}
    {{- if not (kindIs "map" $objectData.targetSelector) -}}
      {{- fail (printf "Ingress - Expected [targetSelector] to be a [map], but got [%s]" (kindOf $objectData.targetSelector)) -}}
    {{- end -}}

    {{- $selectors := $objectData.targetSelector | keys | len -}}
    {{- if (gt $selectors 1) -}}
      {{ fail (printf "Ingress - Expected [targetSelector] to have exactly one key, but got [%d]" $selectors) -}}
    {{- end -}}

    {{- range $k, $v := $objectData.targetSelector -}}
      {{- if not $v -}}
        {{- fail (printf "Ingress - Expected [targetSelector.%s] to have a value" $k) -}}
      {{- end -}}

      {{- if not (kindIs "string" $v) -}}
        {{- fail (printf "Ingress - Expected [targetSelector.%s] to be a [string], but got [%s]" $k (kindOf $v)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $objectData.ingressClassName -}}
    {{- $icn := tpl $objectData.ingressClassName $rootCtx -}}
    {{- if eq $icn "tc-stopped" -}}
      {{- fail "Ingress - Expected [ingressClassName] to not be [tc-stopped], this is reserved for internal use" -}}
    {{- end -}}
  {{- end -}}

  {{- if not $objectData.hosts -}}
    {{- fail "Ingress - Expected non-empty [hosts]" -}}
  {{- end -}}

  {{- if not (kindIs "slice" $objectData.hosts) -}}
    {{- fail (printf "Ingress - Expected [hosts] to be a [slice], but got [%s]" (kindOf $objectData.hosts)) -}}
  {{- end -}}

  {{- range $h := $objectData.hosts -}}
    {{- if not $h.host -}}
      {{- fail "Ingress - Expected non-empty [hosts.host]" -}}
    {{- end -}}

    {{- $host := tpl $h.host $rootCtx -}}
    {{- if (hasPrefix "http://" $host) -}}
      {{- fail (printf "Ingress - Expected [hosts.host] to not start with [http://], but got [%s]" $host) -}}
    {{- end -}}
    {{- if (hasPrefix "https://" $host) -}}
      {{- fail (printf "Ingress - Expected [hosts.host] to not start with [https://], but got [%s]" $host) -}}
    {{- end -}}
    {{- if (contains ":" $host) -}}
      {{- fail (printf "Ingress - Expected [hosts.host] to not contain [:], but got [%s]" $host) -}}
    {{- end -}}

    {{- if and $h.paths (not (kindIs "slice" $h.paths)) -}}
      {{- fail (printf "Ingress - Expected [hosts.paths] to be a [slice], but got [%s]" (kindOf $h.paths)) -}}
    {{- end -}}

    {{- range $p := $h.paths -}}
      {{- $pathType := "Prefix" -}}
      {{- if $p.pathType -}}
        {{- $pathType = tpl $p.pathType $rootCtx -}}
      {{- end -}}

      {{- $validPathTypes := (list "Prefix" "Exact" "ImplementationSpecific") -}}
      {{- if not (mustHas $pathType $validPathTypes) -}}
        {{- fail (printf "Ingress - Expected [hosts.paths.pathType] to be one of [%s], but got [%s]" (join ", " $validPathTypes) $pathType) -}}
      {{- end -}}

      {{- $path := tpl ($p.path | default "/") $rootCtx -}}
      {{- $prefixSlashTypes := (list "Prefix" "Exact") -}}
      {{- if (mustHas $pathType $prefixSlashTypes) -}}
        {{- if and $path (not (hasPrefix "/" $path)) -}}
          {{- fail (printf "Ingress - Expected [hosts.paths.path] to start with [/], but got [%s]" $path) -}}
        {{- end -}}
      {{- end -}}

      {{/* If at least one thing in overrideService is defined... */}}
      {{- with $p.overrideService -}}
        {{- if not .name -}}
          {{- fail "Ingress - Expected non-empty [hosts.paths.overrideService.name]" -}}
        {{- end -}}
        {{- if not .port -}}
          {{- fail "Ingress - Expected non-empty [hosts.paths.overrideService.port]" -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{- range $t := $objectData.tls -}}
    {{- if not $t.hosts -}}
      {{- fail "Ingress - Expected non-empty [tls.hosts]" -}}
    {{- end -}}

    {{- if not (kindIs "slice" $t.hosts) -}}
      {{- fail (printf "Ingress - Expected [tls.hosts] to be a [slice], but got [%s]" (kindOf $t.hosts)) -}}
    {{- end -}}

    {{- range $h := $t.hosts -}}
      {{- if not $h -}}
        {{- fail "Ingress - Expected non-empty entry in [tls.hosts]" -}}
      {{- end -}}

      {{- $host := tpl $h $rootCtx -}}
      {{- if (hasPrefix "http://" $host) -}}
        {{- fail (printf "Ingress - Expected entry in [tls.hosts] to not start with [http://], but got [%s]" $host) -}}
      {{- end -}}
      {{- if (hasPrefix "https://" $host) -}}
        {{- fail (printf "Ingress - Expected entry in [tls.hosts] to not start with [https://], but got [%s]" $host) -}}
      {{- end -}}
      {{- if (contains ":" $host) -}}
        {{- fail (printf "Ingress - Expected entry in [tls.hosts] to not contain [:], but got [%s]" $host) -}}
      {{- end -}}
    {{- end -}}

    {{- $certOptions := (list "secretName" "certificateIssuer" "clusterCertificate") -}}
    {{- $optsSet := list -}}
    {{- range $opt := $certOptions -}}
      {{- if (get $t $opt) -}}
        {{- $optsSet = mustAppend $optsSet $opt -}}
      {{- end -}}
    {{- end -}}

    {{- if gt ($optsSet | len) 1 -}}
      {{- fail (printf "Ingress - Expected only one of [%s] to be set, but got [%s]" (join ", " $certOptions) (join ", " $optsSet)) -}}
    {{- end -}}

  {{- end -}}

{{- end -}}

{{/* Ingress Primary Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.ingress.primaryValidation" $ -}}
*/}}

{{- define "tc.v1.common.lib.ingress.primaryValidation" -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{- range $name, $ingress := $.Values.ingress -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
              "rootCtx" $ "objectData" $ingress
              "name" $name "caller" "Ingress"
              "key" "ingress")) -}}

    {{/* If ingress is enabled */}}
    {{- if eq $enabled "true" -}}
      {{- $hasEnabled = true -}}

      {{/* And ingress is primary */}}
      {{- if and (hasKey $ingress "primary") ($ingress.primary) -}}
        {{/* Fail if there is already a primary ingress */}}
        {{- if $hasPrimary -}}
          {{- fail "Ingress - Only one ingress can be primary" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{/* Require at least one primary ingress, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "Ingress - At least one enabled ingress must be primary" -}}
  {{- end -}}

{{- end -}}
