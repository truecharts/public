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

    {{- if .Values.frigate.model.enabled }}
    model:
      {{- with .Values.frigate.model.path }}
      path: {{ . }}
      {{- end }}
      {{- with .Values.frigate.model.labelmap_path }}
      path: {{ . }}
      {{- end }}
      width: {{ .Values.frigate.model.width | default 320 }}
      height: {{ .Values.frigate.model.height | default 320 }}
      {{- with .Values.frigate.model.labelmap }}
      labelmap:
        {{- range . }}
        {{ .model }}: {{ .name }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- if .Values.frigate.logger.enabled }}
    logger:
      default: {{ .Values.frigate.logger.default | default "info" }}
      {{- with .Values.frigate.logger.logs }}
      logs:
        {{- range . }}
        {{ .component }}: {{ .verbosity }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- if .Values.frigate.birdseye.enabled }}
    birdseye:
      enabled: true
      width: {{ .Values.frigate.birdseye.width | default 1280 }}
      height: {{ .Values.frigate.birdseye.height | default 720 }}
      quality: {{ .Values.frigate.birdseye.quality | default 8 }}
      model: {{ .Values.frigate.birdseye.mode | default "objects" }}
    {{- end }}

    {{- if .Values.frigate.ffmpeg.enabled }}
    ffmpeg:
      global_args: {{ .Values.frigate.ffmpeg.global_args | default "-hide_banner -loglevel warning" }}
      input_args: {{ .Values.frigate.ffmpeg.input_args | default "-avoid_negative_ts make_zero -fflags +genpts+discardcorrupt -rtsp_transport tcp -timeout 5000000 -use_wallclock_as_timestamps 1" }}
      {{- with .Values.frigate.ffmpeg.hwaccel_args }}
      hwaccel_args: {{ join " " . }}
      {{- end }}
      output_args:
        detect: {{ .Values.frigate.ffmpeg.output_args.detect | default "-f rawvideo -pix_fmt yuv420p" }}
        record: {{ .Values.frigate.ffmpeg.output_args.detect | default "-f segment -segment_time 10 -segment_format mp4 -reset_timestamps 1 -strftime 1 -c copy -an" }}
        rtmp: {{ .Values.frigate.ffmpeg.output_args.detect | default "-c copy -f flv" }}
    {{- end }}
{{- end }}
