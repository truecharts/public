{{/* Containers Basic Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.primaryValidation" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
*/}}
{{- define "tc.v1.common.lib.container.primaryValidation" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{/* Go over the contaienrs */}}
  {{- range $name, $container := $objectData.podSpec.containers -}}

    {{/* If container is enabled */}}
    {{- if $container.enabled -}}
      {{- $hasEnabled = true -}}

      {{/* And container is primary */}}
      {{- if and (hasKey $container "primary") ($container.primary) -}}

        {{/* Fail if there is already a primary container */}}
        {{- if $hasPrimary -}}
          {{- fail "Container - Only one container can be primary per workload" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

      {{- end -}}
    {{- end -}}

  {{- end -}}

  {{/* Require at least one primary container, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "Container - At least one enabled container must be primary per workload" -}}
  {{- end -}}

{{- end -}}
