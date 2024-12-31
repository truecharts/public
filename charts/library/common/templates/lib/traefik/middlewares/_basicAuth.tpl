{{- define "tc.v1.common.class.traefik.middleware.basicAuth" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $mw := $objectData.data -}}

  {{- $secret := $mw.secret | default "" -}}
  {{- $users := list -}}
  {{- $secretData := dict -}}

  {{- if and $mw.users $mw.secret -}}
    {{- fail "Middleware (basic-auth) - Expected either [users] or [secret] to be set, but not both" -}}
  {{- end -}}
  {{- if and (not $mw.users) (not $mw.secret) -}}
    {{- fail "Middleware (basic-auth) - Expected at least one of [users] or [secret] to be set" -}}
  {{- end -}}

  {{- if $mw.users -}}
    {{- $secret = $objectData.name -}}
    {{- range $userData := $mw.users -}}
      {{- $users = append $users (htpasswd $userData.username $userData.password) -}}
    {{- end -}}
    {{- $secretData = (dict
      "name" $objectData.name
      "labels" ($objectData.labels | default dict)
      "annotations" ($objectData.annotations | default dict)
      "data" (dict "users" ($users | join "\n"))) -}}
  {{- end }}
  basicAuth:
    secret: {{ $secret }}
{{- if $secretData -}}
  {{- include "tc.v1.common.class.secret" (dict "rootCtx" $rootCtx "objectData" $secretData) -}}
{{- end -}}
{{- end -}}
