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
        - name: {{ printf "%s-start" $jobName }}
          image: '{{ include "tc.common.images.selector" . }}'
          securityContext:
            runAsUser: 33
            runAsGroup: 33
            readOnlyRootFilesystem: true
            runAsNonRoot: true
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
              until $(curl --output /dev/null --silent --head --fail -H "Host: test.fakedomain.dns" http://{{ printf "%s" $jobName }}:{{ .Values.service.main.ports.main.port }}/status.php); do
                  echo "Nextcloud not found... waiting..."
                  sleep 10
              done
              until $(curl --silent --fail -H "Host: test.fakedomain.dns" http://{{ printf "%s" $jobName }}:{{ .Values.service.main.ports.main.port }}/status.php | jq --raw-output '.installed' | grep "true"); do
                  echo "Nextcloud not installed... waiting..."
                  sleep 10
              done
              until $(curl --silent --fail -H "Host: test.fakedomain.dns" http://{{ printf "%s" $jobName }}:{{ .Values.service.main.ports.main.port }}/status.php | jq --raw-output '.maintenance' | grep "false"); do
                  echo "Nextcloud in maintenance mode... waiting..."
                  sleep 10
              done
              until $(curl --silent --fail -H "Host: test.fakedomain.dns" http://{{ printf "%s" $jobName }}:{{ .Values.service.main.ports.main.port }}/status.php | jq --raw-output '.needsDbUpgrade' | grep "false"); do
                  echo "Nextcloud db-Upgrade required... waiting..."
                  sleep 10
              done
              echo  "Nextcloud instance found!"

              echo  "Waiting for High Performance Backend to become available..."
              until $(curl --output /dev/null --silent --head --fail -H "Host: test.fakedomain.dns" http://{{ printf "%s-hpb" $jobName }}:{{ .Values.service.hpb.ports.hpb.port }}/push); do
                  echo "High Performance Backend not found... waiting..."
                  sleep 10
              done
              echo  "High Performance Backend found..."
              echo  "Configuring High Performance Backend for url: ${ACCESS_URL}"
              run_as "php /var/www/html/occ notify_push:setup ${ACCESS_URL}/push"
              EOF
          env:
            - name: NEXTCLOUD_URL
              value: 'http://127.0.0.1:8080'
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
