{{/*
This template ensures pods with postgresql dependency have a delayed start
*/}}
{{- define "common.dependencies.postgresql.init" -}}
{{- $pghost := printf "%v-%v" .Release.Name "postgresql" }}
{{- if .Values.postgresql.enabled }}
- name: postgresql-init
  image: "{{ .Values.postgresqlImage.repository}}:{{ .Values.postgresqlImage.tag }}"
  securityContext:
    capabilities:
      drop:
        - ALL
  resources:
  {{- with .Values.resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  command:
    - "sh"
    - "-c"
    - "until pg_isready -U {{ .Values.postgresql.postgresqlUsername }} -h {{ $pghost }}; do sleep 2 ; done"
  imagePullPolicy: IfNotPresent
{{- end }}
{{- end -}}
