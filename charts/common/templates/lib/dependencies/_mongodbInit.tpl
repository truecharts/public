{{/*
This template ensures pods with mongodb dependency have a delayed start
*/}}
{{- define "common.dependencies.mongodb.init" -}}
{{- if .Values.mongodb.enabled }}
- name: mongodb-init
  image: "{{ .Values.mongodbImage.repository}}:{{ .Values.mongodbImage.tag }}"
  env:
    - name: MONGODB_HOST
      valueFrom:
        secretKeyRef:
          name: mongodbcreds
          key: plainhost
    - name: MONGODB_DATABASE
      value: "{{ .Values.mongodb.mongoDatabase }}"
  securityContext:
    capabilities:
      drop:
        - ALL
  resources:
  {{- with .Values.resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  command: ["bash", "-ec"]
  args:
    - >
      until
        echo "db.runCommand(\"ping\").ok" | mongo --host ${MONGODB_HOST} --port 27017 ${MONGODB_DATABASE} --quiet;
        do sleep 2;
      done
  imagePullPolicy: IfNotPresent
{{- end }}
{{- end -}}
