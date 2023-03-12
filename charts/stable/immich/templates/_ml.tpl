{{/* Define the ml container */}}
{{- define "immich.ml" -}}
  {{- if hasKey .Values "imageML" -}} {{/* For smooth upgrade, Remove later*/}}
    {{- $img := .Values.imageML -}}
    {{- $_ := set .Values "mlImage" (dict "repository" $img.repository "tag" $img.tag "pullPolicy" $img.pullPolicy) -}}
  {{- end }}
enabled: true
imageSelector: mlImage
imagePullPolicy: {{ .Values.mlImage.pullPolicy }}
command:
  {{- if .Values.persistence.modelcache }}{{/* Only change command after upgrade */}}
  - python
  - src/main.py
  {{- else }}
  - /bin/sh
  - ./entrypoint.sh
  {{- end }}
envFrom:
  - configMapRef:
      name: 'common-config'
  - configMapRef:
      name: 'server-config'
  - secretRef:
      name: 'immich-secret'
probes:
  #readiness:
  #  exec:
  #    command:
  #      - /bin/sh
  #      - -c
  #      - |
  #        grep -q main.js /proc/1/cmdline || exit 1
  #
  #
  #
  #
  #liveness:
  #  exec:
  #    command:
  #      - /bin/sh
  #      - -c
  #      - |
  #        grep -q main.js /proc/1/cmdline || exit 1
  #
  #
  #
  #
  #startup:
  #  exec:
  #    command:
  #      - /bin/sh
  #      - -c
  #      - |
  #        grep -q main.js /proc/1/cmdline || exit 1
  #
  #
  #
  #
{{- end -}}
