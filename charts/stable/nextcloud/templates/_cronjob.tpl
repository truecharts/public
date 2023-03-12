{{/* Define the cronjob */}}
{{- define "nextcloud.cronjob" -}}
{{- if .Values.cronjob.enabled -}}
enabled: true
type: "CronJob"

podSpec:
  restartPolicy: Never
  containers:
    cron:
      imageSelector: image
      imagePullPolicy: {{ default .Values.image.pullPolicy }}
      command:
        - "/bin/sh"
        - "-c"
        - |
          /bin/bash <<'EOF'
          echo "running nextcloud cronjob..."
          php -f /var/www/html/cron.php
          echo "cronjob finished"
          {{- if .Values.cronjob.generatePreviews }}
          echo "Pre-generating Previews..."
          php /var/www/html/occ preview:pre-generate
          echo "Previews generated."
          {{- end }}
          EOF
      securityContext:
        runAsUser: 33
        runAsGroup: 33
        readOnlyRootFilesystem: true
{{- end -}}
{{- end -}}
