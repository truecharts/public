{{/* Define the args */}}
{{- define "code-server.args" -}}
args:
  - --user-data-dir
  - "/config/.vscode"
  {{- if .Values.env.PASSWORD }}
  {{ else }}
  - --auth
  - none
  {{- end }}
{{- end -}}
