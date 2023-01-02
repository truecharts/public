{{/* Define the secret */}}
{{- define "terraria.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $params := list }}
{{- $params = append $params (printf "-port %v" .Values.service.main.ports.main.port) -}}
{{- $params = mustAppend $params (printf " -password %v" .Values.terraria.pass) -}}
{{- $params = mustAppend $params (printf " -autocreate %v" .Values.terraria.autocreate) -}}
{{- $params = mustAppend $params (printf " -seed %v" .Values.terraria.seed) -}}
{{- $params = mustAppend $params (printf " -worldname %v" .Values.terraria.worldname) -}}
{{- $params = mustAppend $params (printf " -motd %v" .Values.terraria.motd) -}}
{{- $params = mustAppend $params (printf " -maxplayers %v" .Values.terraria.maxplayers) -}}
{{- $params = mustAppend $params (printf " -lang %v" .Values.terraria.lang) -}}

{{- range $key, $value := .Values.terraria.easy_game_params -}}
  {{- if $value -}}
    {{- $params = mustAppend $params (printf " -%s" $key) -}}
  {{- end -}}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  GAME_PARAMS: {{ printf "%s %s" (join " " $params) (join " " .Values.terraria.game_params) | quote }}
{{- end -}}
