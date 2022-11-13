{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}

{{- $configName := printf "%s-frigate-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  config.yml:
    mqtt:
      host: {{ required "You need to provide an MQTT host" .Values.frigate.mqtt.host }}
      port: {{ .Values.frigate.mqtt.port | default 1883 }}
      topic_prefix: {{ .Values.frigate.mqtt.topic_prefix | default "frigate" }}
      client_id: {{ .Values.frigate.mqtt.client_id | default "frigate" }}
      stats_interval: {{ .Values.frigate.mqtt.stats_interval| default 60 }}
      {{- with .Values.frigate.mqtt.user }}
      user: {{ . }}
      {{- end }}
      {{- with .Values.frigate.mqtt.password }}
      password: {{ . }}
      {{- end }}

    {{- if .Values.frigate.detectors.enabled }}
    {{- if .Values.frigate.detectors.config }}
    detectors:
      {{- range .Values.frigate.detectors.config }}
      {{ required "You need to provide a detector name" .name }}:
        type: {{ .type }}
        {{- with .device }}
        device: {{ . }}
        {{- end }}
        {{- with .num_threads }}
        num_threads: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{- end }}

{{- end }}
