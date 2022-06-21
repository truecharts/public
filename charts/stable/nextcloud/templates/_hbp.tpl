{{/* Define the hbp container */}}
{{- define "nextcloud.hpb" -}}
image: '{{ include "tc.common.images.selector" . }}'
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
{{- with .Values.securityContext }}
securityContext:
  {{- tpl ( toYaml . ) $ | nindent 2 }}
{{- end }}
{{- with (include "tc.common.controller.volumeMounts" . | trim) }}
volumeMounts:
  {{ nindent 2 . }}
{{- end }}
ports:
  - containerPort: 7867
readinessProbe:
  tcpSocket:
    port: 7867
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: 7867
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  tcpSocket:
    port: 7867
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
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

    echo "Waiting for notify_push file to be available..."
    until [ -f /var/www/html/custom_apps/notify_push/bin/x86_64/notify_push ]
    do
         sleep 30
         echo "Notify_push not found... waiting..."
    done
    echo "Notify_push found... Launching High Performance Backend..."
    /var/www/html/custom_apps/notify_push/bin/x86_64/notify_push /var/www/html/config/config.php
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
