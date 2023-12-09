{{/* Define the secret */}}
{{- define "somfyprotect2mqtt.secret" -}}

{{- $secretName := (printf "%s-somfyprotect2mqtt-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $secretStorageName := (printf "%s-somfyprotect2mqtt-storage-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $sp2mqtt := .Values.somfyprotect2mqtt }}
enabled: true

data:
  config.yaml: |
    somfy_protect:
      username: {{ $sp2mqtt.somfy.username | quote }}
      password: {{ $sp2mqtt.somfy.password | quote }}

      {{- with $sp2mqtt.somfy.sites }}
      sites:
        {{- range $site := . }}
        - {{ . }}
        {{- end }}
      {{- end }}

    homeassistant_config:
      {{- with $sp2mqtt.ha.alarm_code }}
      code: {{ . }}
      {{- end }}
      code_arm_required: {{ ternary "true" "false" $sp2mqtt.ha.alarm_code_arm_required }}
      code_disarm_required: {{ ternary "true" "false" $sp2mqtt.ha.alarm_code_disarm_required }}

    mqtt:
      host: {{ $sp2mqtt.mqtt.host }}
      port: {{ $sp2mqtt.mqtt.port }}
      username: {{ $sp2mqtt.mqtt.username | quote }}
      password: {{ $sp2mqtt.mqtt.password | quote }}
      client-id: {{ $sp2mqtt.mqtt.client_id }}
      topic_prefix: {{ $sp2mqtt.mqtt.topic_prefix | quote }}
      ha_discover_prefix: {{ $sp2mqtt.mqtt.ha_discover_prefix | quote }}

    delay_site: {{ $sp2mqtt.delay_site }}
    delay_device: {{ $sp2mqtt.delay_device }}
    manual_snapshot: {{ ternary "true" "false" $sp2mqtt.manual_snapshot }}
{{- end -}}
