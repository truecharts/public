{{- define "nextcloud.init.perms" -}}
{{- $uid := .Values.securityContext.container.runAsUser -}}
{{- $gid := .Values.securityContext.container.runAsGroup -}}
{{- $path := .Values.persistence.data.targetSelector.main.main.mountPath }}
enabled: true
type: install
imageSelector: alpineImage
resources:
  excludeExtra: true
securityContext:
  runAsUser: 0
  runAsGroup: 0
  runAsNonRoot: false
  capabilities:
    disableS6Caps: true
    add:
      - DAC_OVERRIDE
      - FOWNER
      - CHOWN
command: /bin/sh
args:
  - -c
  - |
    echo "Setting permissions to 700 on data directory [{{ $path }}] ..."
    chmod 770 {{ $path }} | echo "Failed to set permissions on data directory [{{ $path }}]"

    echo "Setting ownership to {{ $uid }}:{{ $gid }} on data directory [{{ $path }}] ..."
    chown {{ $uid }}:{{ $gid }} {{ $path }} | echo "Failed to set ownership on data directory [{{ $path }}]"

    echo "Finished."
{{- end -}}
