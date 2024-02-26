{{- define "tc.v1.common.lib.util.verifycrd" -}}
  {{- $crd := .crd -}}
  {{- $missing := .missing | default (printf "Missing CRDs for %s" $crd) -}}
  {{- $rootCtx := .rootCtx -}}

  {{- if $rootCtx.Values.crd.verify.enabled -}}
    {{- $lookupMiddlewares := (lookup "apiextensions.k8s.io/v1" "CustomResourceDefinition" "" $crd) -}}
    {{/* If there are items, re-assign the variable */}}
    {{- if $lookupMiddlewares -}}
    {{- else -}}
      {{- fail (printf "%s has to be installed first" $missing) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
