{{/* Return the name of the primary Cert object */}}
{{- define "tc.v1.common.lib.util.cert.primary" -}}
  {{- $Certs := $.Values.cert -}}

  {{- $enabledCerts := dict -}}
  {{- range $name, $cert := $Certs -}}
    {{- if $cert.enabled -}}
      {{- $_ := set $enabledCerts $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $cert := $enabledCerts -}}
    {{- if and (hasKey $cert "primary") $cert.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $Certs | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
