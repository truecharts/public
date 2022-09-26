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
         echo "Notify_push app not found... waiting..."
    done
    echo "Waiting for Nextcloud to start..."
    until $(curl --output /dev/null --silent --head --fail -H "Host: test.fakedomain.dns" http://127.0.0.1:8080/status.php); do
        echo "Nextcloud not responding... waiting..."
        sleep 10
    done
    until $(curl --silent --fail -H "Host: test.fakedomain.dns" http://127.0.0.1:8080/status.php | jq --raw-output '.installed' | grep "true"); do
        echo "Nextcloud not installed... waiting..."
        sleep 10
    done
    echo "Nextcloud instance with Notify_push found... Launching High Performance Backend..."
    /var/www/html/custom_apps/notify_push/bin/x86_64/notify_push /var/www/html/config/config.php &

    {{- $accessurl := (  printf "http://%v:%v" ( .Values.env.AccessIP | default ( printf "%v-%v" .Release.Name "nextcloud" ) ) .Values.service.main.ports.main.port ) }}
    {{- if .Values.ingress.main.enabled }}
      {{- with (first .Values.ingress.main.hosts) }}
      {{- $accessurl = (  printf "https://%s" .host ) }}
      {{- end }}
    {{- end }}

    echo  "Configuring CLI url..."
    php /var/www/html/occ config:system:set overwrite.cli.url --value='{{ $accessurl }}/'

    {{- if .Values.imaginary.enabled }}
    echo  "Imaginary High Performance Previews enabled, enabling it on Nextcloud..."
    php /var/www/html/occ config:system:set preview_imaginary_url --value='http://127.0.0.1:9090'
    php /var/www/html/occ config:system:set preview_max_x --value='{{ .Values.imaginary.preview_max_x }}'
    php /var/www/html/occ config:system:set preview_max_y --value='{{ .Values.imaginary.preview_max_y }}'
    php /var/www/html/occ config:system:set preview_max_memory --value='{{ .Values.imaginary.preview_max_memory }}'
    php /var/www/html/occ config:system:set preview_max_filesize_image --value='{{ .Values.imaginary.preview_max_filesize_image }}'
    # Remove all preview providers and re-add only selected
    php /var/www/html/occ config:system:delete enabledPreviewProviders
    # Add imaginary always
    {{ $c := 0 }} # Initialize counter
    php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Imaginary'{{ $c = add1 $c }}
    {{ if .Values.imaginary.preview_png }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\PNG'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_jpeg }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\JPEG'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_gif }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\GIF'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_bmp }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\BMP'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_xbitmap }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\XBitmap'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_mp3 }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\MP3'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_markdown }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\MarkDown'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_opendoc }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\OpenDocument'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_txt }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\TXT'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_krita }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Krita'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_illustrator }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Illustrator'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_heic }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\HEIC'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_movie }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Movie'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_msoffice2003 }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\MSOffice2003'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_msoffice2007 }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\MSOffice2007'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_msofficedoc }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\MSOfficeDoc'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_pdf }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\PDF'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_photoshop }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Photoshop'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_postscript }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Postscript'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_staroffice }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\StarOffice'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_svg }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\SVG'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_tiff }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\TIFF'{{ $c = add1 $c }}{{ end }}
    {{ if .Values.imaginary.preview_font }}php /var/www/html/occ config:system:set enabledPreviewProviders {{ $c }} --value='OC\Preview\Font'{{ $c = add1 $c }}{{ end }}
    {{- end }}

    # Set default phone region
    {{- with .Values.nextcloud.default_phone_region | upper }}
    php /var/www/html/occ config:system:set default_phone_region --value='{{ . }}'
    {{- end }}

    echo  "Configuring High Performance Backend for url: {{ $accessurl }}"
    php /var/www/html/occ config:app:set notify_push base_endpoint --value='{{ $accessurl }}/push'
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
