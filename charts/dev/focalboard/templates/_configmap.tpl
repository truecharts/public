{{- define "focalboard.configmap" -}}

{{- $pgPass := .Values.cnpg.main.creds.password | trimAll "\"" }}
{{- $pgUser := .Values.cnpg.main.user }}
{{- $pgDB := .Values.cnpg.main.database }}
enabled: true
data:
  focalboard-config: |-
    {
      "serverRoot": "{{ .Values.focalboard.serverRoot }}",
      "port": {{ .Values.service.main.ports.main.port }},
      "dbtype": "postgres",
      "dbconfig": "{{ printf "postgresql://%v:%v@%v-postgresql:5432/%v?sslmode=disable" $pgUser $pgPass .Release.Name $pgDB }}",
      "postgres_dbconfig": "dbname=$pgDB sslmode=disable",
      "useSSL": false,
      "webpath": "./pack",
      "filespath": "/uploads",
      "telemetry": {{ .Values.focalboard.telemetry }},
      "session_expire_time": 2592000,
      "session_refresh_time": 18000,
      "localOnly": {{ .Values.focalboard.localOnly }},
      "enableLocalMode": {{ .Values.focalboard.enableLocalMode }},
      "localModeSocketLocation": "/var/tmp/focalboard_local.socket"
    }
{{- end -}}
