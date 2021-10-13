{{/* Define the configmap */}}
{{- define "hass.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-init
data:
  init.sh: |-
    #!/bin/sh
    if test -f "/config/configuration.yaml"; then
      echo "configuration.yaml exists."
      if grep -q recorder: "/config/configuration.yaml"; then
      echo "configuration.yaml already contains recorder"
      else
      cat /config/init/recorder.default >> /config/configuration.yaml
      fi
    else
    echo "configuration.yaml does NOT exist."
    cp /config/init/configuration.yaml.default /config/configuration.yaml
    cat /config/init/recorder.default >> /config/configuration.yaml
    fi
  configuration.yaml.default: |-
    # Configure a default setup of Home Assistant (frontend, api, etc)
    default_config:

    # Text to speech
    tts:
      - platform: google_translate

    # Example Includes
    # group: !include groups.yaml
    # automation: !include automations.yaml
    # script: !include scripts.yaml
    # scene: !include scenes.yaml
  recorder.default: |-

    recorder:
      purge_keep_days: 30
      commit_interval: 3
      db_url: {{ ( printf "%s?client_encoding=utf8" ( .Values.postgresql.url.complete | trimAll "\"" ) ) | quote }}


{{- end -}}
