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
    database:
      path: /db/frigate.db
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

    {{- if .Values.frigate.model.render_config }}
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

    {{- if .Values.frigate.logger.render_config }}
    logger:
      default: {{ .Values.frigate.logger.default | default "info" }}
      {{- with .Values.frigate.logger.logs }}
      logs:
        {{- range . }}
        {{ .component }}: {{ .verbosity }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- if .Values.frigate.birdseye.render_config }}
    birdseye:
      enabled: {{ ternary "True" "False" .Values.frigate.birdseye.enabled }}
      width: {{ .Values.frigate.birdseye.width | default 1280 }}
      height: {{ .Values.frigate.birdseye.height | default 720 }}
      quality: {{ .Values.frigate.birdseye.quality | default 8 }}
      model: {{ .Values.frigate.birdseye.mode | default "objects" }}
    {{- end }}

    {{- if .Values.frigate.ffmpeg.render_config }}
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

    {{- if .Values.frigate.detect.render_config }}
    detect:
      enabled: {{ ternary "True" "False" .Values.frigate.detect.enabled }}
      width: {{ .Values.frigate.detect.width | default 1280 }}
      width: {{ .Values.frigate.detect.height | default 720 }}
      fps: {{ .Values.frigate.detect.fps | default 5 }}
      max_disappeared: {{ .Values.frigate.detect.max_disappeared | default 25 }}
      stationary:
        interval: {{ .Values.frigate.detect.stationary.interval | default 0 }}
        threshold: {{ .Values.frigate.detect.stationary.threshold | default 50 }}
        {{- if (hasKey .Values.frigate.detect.stationary "max_frames") }}
        {{- if or (hasKey .Values.frigate.detect.stationary.max_frames "default") (hasKey .Values.frigate.detect.stationary.max_frames "objects") }}
        max_frames:
          {{- with .Values.frigate.detect.stationary.max_frames.default }}
          default: {{ . }}
          {{- end }}
          {{- with .Values.frigate.detect.stationary.max_frames.objects }}
          objects:
            {{- range . }}
            {{ .object }}: {{ .frames }}
            {{- end }}
          {{- end }}
        {{- end }}
        {{- end }}
    {{- end }}

    {{- if .Values.frigate.objects.render_config }}
    objects:
      {{- with .Values.frigate.objects.track }}
      track:
        {{- range . }}
        - {{ . }}
        {{- end }}
      {{- end }}
      {{- with .Values.frigate.objects.mask }}
      mask: {{ . }}
      {{- end }}
      {{- with .Values.frigate.objects.filters }}
      filters:
        {{- range . }}
        {{ .object }}:
          {{- with .config.min_area }}
          min_area: {{ . }}
          {{- end }}
          {{- with .config.max_area }}
          max_area: {{ . }}
          {{- end }}
          {{- with .config.min_ratio }}
          min_ratio: {{ . }}
          {{- end }}
          {{- with .config.max_ratio }}
          max_ratio: {{ . }}
          {{- end }}
          {{- with .config.min_score }}
          min_score: {{ . }}
          {{- end }}
          {{- with .config.threshold }}
          threshold: {{ . }}
          {{- end }}
          {{- with .config.mask }}
          mask: {{ . }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- if .Values.frigate.motion.render_config }}
    motion:
      threshold: {{ .Values.frigate.motion.threshold | default 25 }}
      contour_area: {{ .Values.frigate.motion.contour_area | default 30 }}
      delta_alpha: {{ .Values.frigate.motion.delta_alpha | default 0.2 }}
      frame_alpha: {{ .Values.frigate.motion.frame_alpha | default 0.2 }}
      frame_height: {{ .Values.frigate.motion.frame_height | default 50 }}
      {{- with .Values.frigate.motion.mask }}
      mask: {{ . }}
      {{- end }}
      improve_contrast: {{ ternary "True" "False" .Values.frigate.motion.improve_contrast }}
      mqtt_off_delay: {{ .Values.frigate.motion.mqtt_off_delay | default 30 }}
    {{- end }}

    {{- if .Values.frigate.record.render_config }}
    record:
      enable: {{ ternary "True" "False" .Values.frigate.record.enabled }}
      expire_interval: {{ .Values.frigate.record.expire_interval | default 60 }}
      {{- if .Values.frigate.record.retain.render_config }}
      retain:
        days: {{ .Values.frigate.record.retain.days | default 0 }}
        mode: {{ .Values.frigate.record.retain.mode | default "all" }}
      {{- end }}
      events:
        pre_capture: {{ .Values.frigate.record.events.pre_capture | default 5 }}
        post_capture: {{ .Values.frigate.record.events.post_capture | default 5 }}
        {{- with .Values.frigate.record.events.objects }}
        objects:
          {{- range . }}
          - {{ . }}
          {{- end }}
        {{- end }}
        {{- with .Values.frigate.record.events.required_zones }}
        required_zones:
          {{- range . }}
          - {{ . }}
          {{- end }}
        {{- end }}
        {{- if .Values.frigate.record.events.retain.render_config }}
        retain:
          default: {{ .Values.frigate.record.events.retain.default | default 10 }}
          mode: {{ .Values.frigate.record.events.retain.mode | default "motion" }}
          {{- with .Values.frigate.record.events.retain.objects }}
          objects:
          {{- range . }}
            {{ .object }}: {{ .days }}
          {{- end }}
          {{- end }}
        {{- end }}
    {{- end }}

    {{- if .Values.frigate.snapshots.render_config }}
    snapshots:
      enabled: {{ ternary "True" "False" .Values.frigate.snapshots.enabled }}
      clean_copy: {{ ternary "True" "False" .Values.frigate.snapshots.clean_copy }}
      timestamp: {{ ternary "True" "False" .Values.frigate.snapshots.timestamp }}
      bounding_box: {{ ternary "True" "False" .Values.frigate.snapshots.bounding_box }}
      crop: {{ ternary "True" "False" .Values.frigate.snapshots.crop }}
      {{- with .Values.frigate.snapshots.height }}
      height: {{ . }}
      {{- end }}
      {{- with .Values.frigate.snapshots.required_zones }}
      required_zones:
        {{- range . }}
        - {{ . }}
        {{- end }}
      {{- end }}
      {{- if .Values.frigate.snapshots.retain.render_config }}
      retain:
        default: {{ .Values.frigate.snapshots.retain.default | default 10 }}
        {{- with .Values.frigate.snapshots.retain.objects }}
        objects:
        {{- range . }}
          {{ .object }}: {{ .days }}
        {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

    {{- if .Values.frigate.rtmp.render_config }}
    rtmp:
      enabled: {{ ternary "True" "False" .Values.frigate.rtmp.enabled }}
      height: {{ .Values.frigate.live.height | default 720 }}
      quality: {{ .Values.frigate.live.height | default 8 }}
    {{- end }}
{{- end }}
