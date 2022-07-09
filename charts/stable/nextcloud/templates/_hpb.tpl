{{/* Define the hbp container */}}
{{- define "nextcloud.hpb" -}}
{{- $jobName := include "tc.common.names.fullname" . }}
image: '{{ include "tc.common.images.selector" . }}'
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 33
  runAsGroup: 33
  readOnlyRootFilesystem: true
  runAsNonRoot: true
{{- with (include "tc.common.controller.volumeMounts" . | trim) }}
volumeMounts:
  {{ nindent 2 . }}
{{- end }}
ports:
  - containerPort: 7867
readinessProbe:
  httpGet:
    path: /push/test/cookie
    port: 7867
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /push/test/cookie
    port: 7867
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /push/test/cookie
    port: 7867
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    set -m
    echo "Waiting for notify_push file to be available..."
    until [ -f /var/www/html/custom_apps/notify_push/bin/x86_64/notify_push ]
    do
         sleep 10
         echo "Notify_push not found... waiting..."
    done
    echo "Waiting for Nextcloud to start..."
    until $(curl --output /dev/null --silent --head --fail -H "Host: test.fakedomain.dns" http://127.0.0.1:8080/status.php); do
        echo "Nextcloud not found... waiting..."
        sleep 10
    done
    until $(curl --silent --fail -H "Host: test.fakedomain.dns" http://127.0.0.1:8080/status.php | jq --raw-output '.installed' | grep "true"); do
        echo "Nextcloud not installed... waiting..."
        sleep 10
    done
    echo "Nextcloud instance with Notify_push found... Launching High Performance Backend..."
    /var/www/html/custom_apps/notify_push/bin/x86_64/notify_push /var/www/html/config/config.php &

    {{- if .Values.imaginary.enabled }}
    echo  "Imaginary High Performance Previews enabled, enabling it on Nextcloud..."
    php /var/www/html/occ config:system:set enabledPreviewProviders 6 --value='OC\Preview\Imaginary'
    php /var/www/html/occ config:system:set preview_imaginary_url --value='http://127.0.0.1:9090'
    {{- end }}

    until $(curl --output /dev/null --silent --head --fail -H "Host: test.fakedomain.dns" http://127.0.0.1:7867/push/test/cookie); do
        echo "High Performance Backend not running ... waiting..."
        sleep 10
    done
    {{- $accessurl := (  printf "http://%v:%v" ( .Values.env.AccessIP | default ( printf "%v-%v" .Release.Name "nextcloud" ) ) .Values.service.main.ports.main.port ) }}
    {{- if .Values.ingress.main.enabled }}
      {{- with (first .Values.ingress.main.hosts) }}
      {{- $accessurl = (  printf "https://%s" .host ) }}
      {{- end }}
    {{- end }}
    until $(curl --output /dev/null --silent --head --fail {{ $accessurl }}/push/test/cookie); do
        echo "High Performance Backend service not accessable ... waiting..."
        sleep 10
    done
    echo  "High Performance Backend found..."
    echo  "Configuring High Performance Backend for url: {{ $accessurl }}"
    php /var/www/html/occ notify_push:setup {{ $accessurl }}/push
    fg
    EOF
env:
  - name: NEXTCLOUD_URL
    value: 'http://127.0.0.1:8080'
  - name: METRICS_PORT
    value: '7868'
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
envFrom:
  - configMapRef:
      name: nextcloudconfig
{{- end -}}
