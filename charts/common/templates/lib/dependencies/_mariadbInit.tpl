{{/*
This template ensures pods with mariadb dependency have a delayed start
*/}}
{{- define "tc.common.dependencies.mariadb.init" -}}
{{- if .Values.mariadb.enabled }}
- name: mariadb-init
  image: "{{ .Values.mariadbImage.repository}}:{{ .Values.mariadbImage.tag }}"
  env:
    - name: MARIADB_HOST
      valueFrom:
        secretKeyRef:
          name: mariadbcreds
          key: plainhost
    - name: MARIADB_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
          name: mariadbcreds
          key: mariadb-root-password
  securityContext:
    capabilities:
      drop:
        - ALL
  resources:
  {{- with .Values.resources }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  command: ["bash", "-ec"]
  args:
    - >
      until
        mysqladmin -uroot -h"${MARIADB_HOST}" -p"${MARIADB_ROOT_PASSWORD}" ping \
        && mysqladmin -uroot -h"${MARIADB_HOST}" -p"${MARIADB_ROOT_PASSWORD}" status;
        do sleep 2;
      done
  imagePullPolicy: IfNotPresent
{{- end }}
{{- end -}}
