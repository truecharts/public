{{/* Define the hbp container */}}
{{- define "nextcloud.hpb" -}}

image: '{{ include "tc.common.images.selector" . }}'
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 33
  runAsGroup: 33
  readOnlyRootFilesystem: true

probes:
  readiness:

    path: /push/test/cookie
      port: 7867
      httpHeaders:
      - name: Host
        value: "test.fakedomain.dns"




  liveness:

    path: /push/test/cookie
      port: 7867
      httpHeaders:
      - name: Host
        value: "test.fakedomain.dns"




  startup:

    path: /push/test/cookie
      port: 7867
      httpHeaders:
      - name: Host
        value: "test.fakedomain.dns"




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

    {{- $accessurl := (  printf "http://%v:%v" ( .Values.workload.main.podSpec.containers.main.env.AccessIP | default ( printf "%v-%v" .Release.Name "nextcloud" ) ) .Values.service.main.ports.main.port ) }}
    {{- if .Values.ingress.main.enabled }}
      {{- with (first .Values.ingress.main.hosts) }}
      {{- $accessurl = (  printf "https://%s" .host ) }}
      {{- end }}
    {{- end }}

    echo  "Configuring CLI url..."
    php /var/www/html/occ config:system:set overwrite.cli.url --value='{{ $accessurl }}/'

    echo  "Executing standard nextcloud version migration scripts to ensure they are actually ran..."
    php /var/www/html/occ db:add-missing-indices

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
  NEXTCLOUD_URL: 'http://127.0.0.1:8080'
  METRICS_PORT: '7868'
  TRUSTED_PROXIES: "{{ .Values.workload.main.podSpec.containers.main.env.TRUSTED_PROXIES }}"
  POSTGRES_DB: "{{ .Values.cnpg.main.database }}"
  POSTGRES_USER: "{{ .Values.cnpg.main.user }}"
  POSTGRES_PASSWORD
    secretKeyRef:
        name: dbcreds
        key: postgresql-password
  POSTGRES_HOST
    secretKeyRef:
        name: dbcreds
        key: plainporthost
  REDIS_HOST
    secretKeyRef:
        name: rediscreds
        key: plainhost
  REDIS_HOST_PASSWORD
    secretKeyRef:
        name: rediscreds
        key: redis-password
envFrom:
  - configMapRef:
      name: nextcloudconfig
{{- end -}}
