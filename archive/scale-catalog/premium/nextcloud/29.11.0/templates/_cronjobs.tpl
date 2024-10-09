{{- define "nextcloud.cronjobs" -}}
{{- range $cj := .Values.cronjobs }}
  {{- $name := $cj.name | required "Nextcloud - Expected non-empty name in cronjob" -}}
  {{- $schedule := $cj.schedule | required "Nextcloud - Expected non-empty schedule in cronjob" }}

{{ $name }}:
  enabled: {{ $cj.enabled | quote }}
  type: CronJob
  schedule: {{ $schedule | quote }}
  podSpec:
    restartPolicy: Never
    containers:
      {{ $name }}:
        enabled: true
        primary: true
        imageSelector: image
        resources:
          excludeExtra: true
        command:
          - /bin/bash
          - -c
          - |
            {{- range $cj.cmd }}
              {{- . | nindent 12 }}
            {{- else -}}
              {{- fail "Nextcloud - Expected non-empty cmd in cronjob" -}}
            {{- end }}
        probes:
          liveness:
            enabled: false
          readiness:
            enabled: false
          startup:
            enabled: false
{{- end }}
{{- end -}}
