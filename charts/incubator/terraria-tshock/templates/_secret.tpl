{{/* Define the secret */}}
{{- define "terraria.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $params := list }}
{{- $params = append $params (printf "-port %v" .Values.service.main.ports.main.port) -}}
{{- $params = append $params (printf " -password %v" .Values.terraria.pass) -}}
{{- $params = append $params (printf " -autocreate %v" .Values.terraria.autocreate) -}}
{{- $params = append $params (printf " -seed %v" .Values.terraria.seed) -}}
{{- $params = append $params (printf " -worldname %v" .Values.terraria.worldname) -}}
{{- $params = append $params (printf " -motd %v" .Values.terraria.motd) -}}
{{- $params = append $params (printf " -maxplayers %v" .Values.terraria.maxplayers) -}}
{{- $params = append $params (printf " -lang %v" .Values.terraria.lang) -}}

{{- $easyGameParams := list -}}
{{- range $key, $value := .Values.terraria.easy_game_params -}}
  {{- if $value -}}
    {{ $params = mustAppend $easyGameParams (printf " -%s" $key) }}
  {{- end -}}
{{- end -}}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  GAME_PARAMS: {{ printf "%s%s" (join " " $params) (join " " .Values.terraria.game_params) | quote }}
{{- end -}}
