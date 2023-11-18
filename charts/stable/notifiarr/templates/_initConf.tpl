{{- define "notifiarr.init.conf" -}}
{{- $uid := .Values.securityContext.container.runAsUser -}}
{{- $gid := .Values.securityContext.container.runAsGroup -}}
{{- $conf := (printf "%v/%v" .Values.persistence.config.targetSelector.main.main.mountPath "notifiarr.conf") -}}
enabled: true
# We run it on every boot just in case an upgrade (or the user)
# manages to nuke the config file
type: init
imageSelector: alpineImage
securityContext:
  runAsUser: {{ $uid }}
  runAsGroup: {{ $gid }}
command: /bin/sh
# This script creates an (almost) empty config file with the aim to prevent
# Notifiarr from generating a default password.
# When no default password is generated the configured API key and a default
# username ('admin') are used for logging in.
args:
  - -c
  - test -f "{{ $conf }}" && echo "Config exists, skipping creation..." && exit 0

    echo "Creating a minimal config in [{{ $conf }}]..."

    echo "# Dummy comment" > "{{ $conf }}" || echo "Failed to create a minimal config..."

    echo "Finished."
{{- end -}}
