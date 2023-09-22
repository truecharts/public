{{/* Define the secrets */}}
{{- define "ark.secrets" -}}

{{- $secretName := (printf "%s-ark-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $params := list }}
{{- $params = append $params (printf "?Port=%v" .Values.service.main.ports.main.port) -}}
{{- $params = append $params (printf "?QueryPort=%v" .Values.service.query.ports.query.port) -}}
{{- $params = append $params (printf "?RCONPort=%v" .Values.service.rcon.ports.rcon.port) -}}

{{- $gameExtraParams := list -}}
{{- range $key, $value := .Values.ark.easy_game_extra_params -}}
  {{- if $value -}}
    {{ $gameExtraParams = mustAppend $gameExtraParams (printf "-%s" $key) }}
  {{- end -}}
{{- end -}}

{{- if .Values.ark.rcon_enabled -}}
  {{- $params = append $params (print "?RCONEnabled=True") -}}
{{- end }}
enabled: true
data:
  GAME_ID: {{ .Values.ark.game_id | quote }}
  GAME_PARAMS: {{ printf "%s%s" (join "" $params) (join "" .Values.ark.game_params) | quote }}
  GAME_PARAMS_EXTRA: {{ (join " " (concat $gameExtraParams .Values.ark.game_params_extra)) | quote }}
  {{- with .Values.ark.custom_map }}
  MAP: {{ . | quote }}
  {{- else }}
  MAP: {{ .Values.ark.map | quote }}
  {{- end }}
  {{- with .Values.ark.server_name }}
  SERVER_NAME: {{ . | quote }}
  {{- end }}
  VALIDATE: {{ default false .Values.ark.validate | quote }}
  SRV_ADMIN_PWD: {{ .Values.ark.srv_admin_pass | quote }}
  SRV_PWD: {{ .Values.ark.srv_password | quote }}
  {{- with .Values.ark.username }}
  USERNAME: {{ . | quote }}
  {{- end }}
  {{- with .Values.ark.password }}
  PASSWRD: {{ . | quote }}
  {{- end }}
{{- end -}}
