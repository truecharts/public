{{- define "tc.v1.common.lib.cnpg.provider.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $key := .key -}}
  {{- $caller := .caller -}}
  {{- $provider := .provider -}}

  {{- $validProviders := (list "azure" "s3" "google") -}}
  {{- if not (mustHas $provider $validProviders) -}}
    {{- fail (printf "%s - Expected [%s.provider] to be one of [%s], but got [%s]" $caller $key (join ", " $validProviders) $provider) -}}
  {{- end -}}
{{- end -}}
