{{/* Returns the primary networkpolicy object */}}
{{- define "tc.v1.common.lib.util.networkpolicy.primary" -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $result := "" -}}
  {{- range $name, $networkpolicy := $rootCtx.Values.networkpolicy -}}
    {{- $enabled := "false" -}}

    {{- if not (kindIs "invalid" $networkpolicy.enabled) -}}
      {{- $enabled = (include "tc.v1.common.lib.util.enabled" (dict
                "rootCtx" $rootCtx "objectData" $networkpolicy
                "name" $name "caller" "Primary networkpolicy Util"
                "key" "networkpolicy")) -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}
      {{- if $networkpolicy.primary -}}
        {{/*
          While this will overwrite if there are
          more than 1 primary networkpolicy, its not an issue
          as there is validation down the line that will
          fail if there are more than 1 primary networkpolicy
        */}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
