{{/* Define the job */}}
{{- define "nextcloud.job" -}}
{{- $jobName := include "tc.common.names.fullname" . }}

---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ printf "%s-start" $jobName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
spec:
  template:
    spec:
      restartPolicy: "OnFailure"
      {{- with (include "tc.common.controller.volumes" . | trim) }}
      volumes:
        {{- nindent 12 . }}
      {{- end }}
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ default .Values.image.tag }}"
          {{- with .Values.securityContext }}
          securityContext:
            {{- tpl ( toYaml . ) $ | nindent 16 }}
          {{- end }}
          {{- with (include "tc.common.controller.volumeMounts" . | trim) }}
          volumeMounts:
            {{ nindent 16 . }}
          {{- end }}
          command:
            - "/bin/sh"
            - "-c"
            - |
              /bin/bash <<'EOF'
              echo "Waiting for Nextcloud to start..."
              until $(curl --output /dev/null --silent --head --fail -H "Host: test.fakedomain.dns" http://127.0.0.1/status.php); do
                  printf '.'
                  sleep 5
              done

              echo  "Nextcloud instance found!"
              echo  "Waiting for 30 seconds before High Performance Backend setup..."
              sleep 30
              echo  "Configuring High Performance Backend for url: ${ACCESS_URL}"
              run_as "php /var/www/html/occ notify_push:setup ${ACCESS_URL}/push"
              EOF
          env:
            - name: NEXTCLOUD_URL
              value: 'http://127.0.0.1'
            - name: TRUSTED_PROXIES
              value: "{{ .Values.env.TRUSTED_PROXIES }}"
            - name: POSTGRES_DB
              value: "{{ .Values.postgresql.postgresqlDatabase }}"
            - name: POSTGRES_USER
              value: "{{ .Values.postgresql.postgresqlUsername }}"
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: dbcreds
                  key: postgresql-password
            - name: POSTGRES_HOST
              valueFrom:
                secretKeyRef:
                  name: dbcreds
                  key: plainporthost
            - name: REDIS_HOST
              valueFrom:
                secretKeyRef:
                  name: rediscreds
                  key: plainhost
            - name: REDIS_HOST_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: rediscreds
                  key: redis-password

{{- end -}}
