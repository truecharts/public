{{/* Return the name of the enabled primary ingress object */}}
{{- define "tc.v1.common.lib.util.ingress.primary" -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $result := "" -}}
  {{- range $name, $ingress := $rootCtx.Values.ingress -}}
    {{- $enabled := "false" -}}

    {{- if not (kindIs "invalid" $ingress.enabled) -}}
      {{- $enabled = (include "tc.v1.common.lib.util.enabled" (dict
                "rootCtx" $rootCtx "objectData" $ingress
                "name" $name "caller" "Primary Ingress Util"
                "key" "ingress")) -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}
      {{- if $ingress.primary -}}
        {{/*
          While this will overwrite if there are
          more than 1 primary ingress, its not an issue
          as there is validation down the line that will
          fail if there are more than 1 primary ingress
        */}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
