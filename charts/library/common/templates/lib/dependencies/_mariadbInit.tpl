{{/*
This template ensures pods with postgresql dependency have a delayed start
*/}}
{{- define "common.dependencies.mariadb.init" -}}
{{- $pghost := printf "%v-%v" .Release.Name "mariadb" }}
{{- if .Values.mariadb.enabled }}
- name: mariadb-init
  image: "{{ .Values.mariadblImage.repository}}:{{ .Values.mariadblImage.tag }}"
  securityContext:
    capabilities:
      drop:
        - ALL
  resources:
  {{- with .Values.resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  command:
    - "bash"
    - "-ec"
    - "until /opt/bitnami/scripts/mariadb/healthcheck.sh; do sleep 2; done"
  imagePullPolicy: IfNotPresent
{{- end }}
{{- end -}}
