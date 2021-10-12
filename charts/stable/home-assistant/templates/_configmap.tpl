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
    echo "postgresql password: {{ ( printf "%v%v:%v@%v-%v:%v/%v?client_encoding=utf8" "postgresql://" .Values.postgresql.postgresqlUsername .Values.postgresql.Password .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | quote }}"
    if test -f "/config/configuration.yaml"; then
      echo "configuration.yaml exists."
      if grep -q recorder: "/config/configuration.yaml"; then
      echo "configuration.yaml already contains recorder"
      fi
    else
    echo "configuration.yaml does NOT exist."
    cp /config/init/configuration.yaml.default /config/configuration.yaml
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

    recorder:
      db_url: {{ ( printf "%s?client_encoding=utf8" ( .Values.postgresql.url.complete | trimAll "\"" ) ) | quote }}

{{- end -}}
