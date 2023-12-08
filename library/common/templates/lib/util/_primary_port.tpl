{{/* A dict containing .values and .serviceName is passed when this function is called */}}
{{/* Return the primary port for a given Service object. */}}
{{- define "tc.v1.common.lib.util.service.ports.primary" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $svcValues := .svcValues -}}

  {{- $result := "" -}}
  {{- range $name, $port := $svcValues.ports -}}
    {{- $enabled := "false" -}}

    {{- if not (kindIs "invalid" $port.enabled) -}}
      {{- $enabled = (include "tc.v1.common.lib.util.enabled" (dict
                "rootCtx" $rootCtx "objectData" $port
                "name" $name "caller" "Primary Port Util"
                "key" ".ports.$portname.enabled")) -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}
      {{- if $port.primary -}}
        {{/*
          While this will overwrite if there are
          more than 1 primary port, its not an issue
          as there is validation down the line that will
          fail if there are more than 1 primary port
        */}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
