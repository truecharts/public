{{- define "nextcloud.init.perms" -}}
{{- $uid := .Values.securityContext.container.runAsUser -}}
{{- $gid := .Values.securityContext.container.runAsGroup -}}
{{- $path := .Values.persistence.data.targetSelector.main.main.mountPath -}}
enabled: true
type: {{ ternary "init" "install" .Values.nextcloud.general.fix_data_permissions }}
imageSelector: image
securityContext:
  runAsUser: 0
  runAsGroup: 0
  runAsNonRoot: false
  capabilities:
    add:
      - DAC_OVERRIDE
      - FOWNER
      - CHOWN
command: /bin/sh
args:
  - -c
  - |
    echo "Setting permissions to 700 on data directory [{{ $path }}] (recursively) ..."
    chmod 770 -R {{ $path }}

    echo "Setting ownership to {{ $uid }}:{{ $gid }} on data directory [{{ $path }}] (recursively) ..."
    chown -R {{ $uid }}:{{ $gid }} {{ $path }}

    echo "Finished."
{{- end -}}
