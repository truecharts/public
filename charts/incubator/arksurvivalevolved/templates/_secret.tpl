{{/* Define the secret */}}
{{- define "ark.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $params := list }}
{{- $params = append $params (printf "?Port=%s" .Values.service.main.ports.main.port) -}}
{{- $params = append $params (printf "?QueryPort=%s" .Values.service.udpsteam.ports.udpsteam.port) -}}
{{- $params = append $params (printf "?RCONPort=%s" .Values.service.rcontcp.ports.rcontcp.port) -}}
{{- if .Values.ark.rcon_enabled -}}
  {{- $params = append $params (print "?RCONEnabled=True") -}}
{{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  GAME_ID: {{ .Values.ark.game_id | quote }}
  GAME_PARAMS: {{ printf "%s%s" (join "" $params) (join "" .Values.ark.game_params) | quote }}
  GAME_PARAMS_EXTRA: {{ (join " " .Values.ark.game_params_extra) | quote }}
  MAP: {{ .Values.ark.map | quote }}
  {{- with .Values.ark.server_name }}
  SERVER_NAME: {{ . | quote }}
  {{- end }}
  VALIDATE: {{ default false .Values.ark.validate | quote }}
  {{- with .Values.ark.srv_admin_password }}
  SRV_ADMIN_PWD: {{ . | quote }}
  {{- end }}
  {{- with .Values.ark.srv_password }}
  SRV_PWD: {{ . | quote }}
  {{- end }}
  {{- with .Values.ark.username }}
  USERNAME: {{ . | quote }}
  {{- end }}
  {{- with .Values.ark.password }}
  PASSWRD: {{ . | quote }}
  {{- end }}
{{- end -}}
