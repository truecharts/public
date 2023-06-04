{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}
enabled: true
data:
  config.yml: |
    database:
      path: /db/frigate.db

    mqtt:
      {{- include "frigate.mqtt" .Values.frigate.mqtt | indent 6 }}

    {{- if and .Values.frigate.detectors.render_config .Values.frigate.detectors.config }}
    detectors:
      {{- include "frigate.detectors" .Values.frigate.detectors | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.model.render_config }}
    model:
      {{- include "frigate.model" .Values.frigate.model | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.logger.render_config }}
    logger:
      {{- include "frigate.logger" .Values.frigate.logger | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.birdseye.render_config }}
    birdseye:
      {{- include "frigate.birdseye" .Values.frigate.birdseye | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.ffmpeg.render_config }}
    ffmpeg:
      {{- include "frigate.ffmpeg" .Values.frigate.ffmpeg | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.detect.render_config }}
    detect:
      {{- include "frigate.detect" .Values.frigate.detect | indent 6 }}
    {{- end -}}

    {{- if .Values.frigate.objects.render_config }}
    objects:
      {{- include "frigate.objects" .Values.frigate.objects | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.motion.render_config }}
    motion:
      {{- include "frigate.motion" .Values.frigate.motion | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.record.render_config }}
    record:
      {{- include "frigate.record" .Values.frigate.record | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.snapshots.render_config }}
    snapshots:
      {{- include "frigate.snapshots" .Values.frigate.snapshots | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.rtmp.render_config }}
    rtmp:
      {{- include "frigate.rtmp" .Values.frigate.rtmp | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.live.render_config }}
    live:
      {{- include "frigate.live" .Values.frigate.live | indent 6 }}
    {{- end }}

    {{- if .Values.frigate.timestamp_style.render_config }}
    timestamp_style:
      {{- include "frigate.timestamp_style" .Values.frigate.timestamp_style | indent 6 }}
    {{- end }}

    {{- $cameras := .Values.frigate.cameras }}
    cameras:
    {{- range $cam := $cameras }}
      {{ $cam.camera_name | required "You need to provide a camera name" }}:
        ffmpeg:
          inputs:
            {{- range $input := $cam.ffmpeg.inputs }}
            - path: {{ $input.path | required "You need to provide a path" }}
              roles:
              {{- range $role := $input.roles }}
                - {{ $role }}
              {{- else -}}
                {{- fail "You need to provide roles" -}}
              {{- end -}}
              {{- include "frigate.ffmpeg" $input | indent 14 }}
            {{- end -}} {{/* End range $cam.ffmpeg.inputs */}}
          {{- include "frigate.ffmpeg" $cam.ffmpeg | indent 10 }}
        {{- with $cam.best_image_timeout }}
        best_image_timeout: {{ . }}
        {{- end -}}
        {{- with $cam.zones }}
        zones:
          {{- range $zone := . }}
          {{ $zone.name | required "You have to specify a zone name" }}:
            coordinates: {{ required "You have to specify coordinates" .coordinates }}
            {{- with $zone.objects }}
            objects:
              {{- range $obj := . }}
              - {{ $obj }}
              {{- end -}}
            {{- end -}}
            {{- with $zone.filters }}
            filters:
              {{- range $filter := . }}
              {{ $filter.object | required "You have to specify an object" }}:
                {{- with $filter.min_area }}
                min_area: {{ . }}
                {{- end -}}
                {{- with $filter.max_area }}
                max_area: {{ . }}
                {{- end -}}
                {{- with $filter.threshold }}
                threshold: {{ . }}
                {{- end -}}
              {{- end -}} {{/* end range filters */}}
            {{- end -}} {{/* end with filter */}}
          {{- end -}} {{/* end range zones */}}
        {{- end -}} {{/* end with zones */}}
        {{- if $cam.mqtt.render_config -}}
        {{- with $cam.mqtt }}
        mqtt:
          enabled: {{ ternary "True" "False" .enabled }}
          timestamp: {{ ternary "True" "False" .timestamp }}
          bounding_box: {{ ternary "True" "False" .bounding_box }}
          crop: {{ ternary "True" "False" .crop }}
          {{- with .height }}
          height: {{ . }}
          {{- end -}}
          {{- with .quality }}
          quality: {{ . }}
          {{- end -}}
          {{- with .required_zones }}
          required_zones:
            {{- range $zone := . }}
            - {{ $zone }}
            {{- end -}}
          {{- end -}}
        {{- end -}} {{/* end with mqtt */}}
        {{- end -}} {{/* end if mqtt.render_config */}}
        {{- if $cam.ui.render_config -}}
        {{- with $cam.ui }}
        ui:
          {{- if not (kindIs "invalid" .order) }}
          order: {{ .order }}
          {{- end }}
          dashboard: {{ ternary "True" "False" .dashboard }}
        {{- end -}} {{/* end with ui */}}
        {{- end -}} {{/* end if ui.render_config */}}
    {{- end -}} {{/* end range cameras */}}
{{- end }}

{{- define "frigate.ffmpeg" -}}
{{- $ffmpeg := . -}}

{{- with $ffmpeg.global_args }}
global_args: {{ . }}
{{- end -}}
{{- with $ffmpeg.input_args }}
input_args: {{ . }}
{{- end -}}
{{- with $ffmpeg.hwaccel_args }}
hwaccel_args: {{ . }}
{{- end -}}
{{- if $ffmpeg.output_args -}}
{{- if or $ffmpeg.output_args.detect $ffmpeg.output_args.record $ffmpeg.output_args.rtmp }}
output_args:
  {{- with $ffmpeg.output_args.detect }}
  detect: {{ . }}
  {{- end -}}
  {{- with $ffmpeg.output_args.record }}
  record: {{ . }}
  {{- end -}}
  {{- with $ffmpeg.output_args.rtmp }}
  rtmp: {{ . }}
  {{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.detect" -}}
{{- $detect := . }}
enabled: {{ ternary "True" "False" $detect.enabled }}
{{- with $detect.width }}
width: {{ . }}
{{- end -}}
{{- with $detect.height }}
height: {{ . }}
{{- end -}}
{{- with $detect.fps }}
fps: {{ . }}
{{- end -}}
{{- with $detect.max_disappeared }}
max_disappeared: {{ . }}
{{- end -}}
{{- if or (not (kindIs "invalid" $detect.stationary.interval)) $detect.stationary.threshold $detect.stationary.set_max_frames }}
stationary:
  {{- if not (kindIs "invalid" $detect.stationary.interval) }} {{/* invalid kind means its empty (0 is not empty) */}}
  interval: {{ $detect.stationary.interval }}
  {{- end -}}
  {{- with $detect.stationary.threshold }}
  threshold: {{ . }}
  {{- end -}}
  {{- if (hasKey $detect.stationary "max_frames") }}
  {{- if or $detect.stationary.max_frames.default $detect.stationary.max_frames.objects }}
  max_frames:
    {{- with $detect.stationary.max_frames.default }}
    default: {{ . }}
    {{- end -}}
    {{- with $detect.stationary.max_frames.objects }}
    objects:
      {{- range $obj := . }}
      {{ $obj.object | required "You need to provide an object" }}: {{ $obj.frames | required "You need to provide frames" }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.motion" -}}
{{- $motion := . -}}

{{- with $motion.threshold }}
threshold: {{ . }}
{{- end -}}
{{- with $motion.contour_area }}
contour_area: {{ . }}
{{- end -}}
{{- with $motion.delta_alpha }}
delta_alpha: {{ . }}
{{- end -}}
{{- with $motion.frame_alpha }}
frame_alpha: {{ . }}
{{- end -}}
{{- with $motion.frame_height }}
frame_height: {{ . }}
{{- end -}}
{{- with $motion.mask }}
mask: {{ . }}
{{- end }}
improve_contrast: {{ ternary "True" "False" $motion.improve_contrast }}
{{- with $motion.mqtt_off_delay }}
mqtt_off_delay: {{ . }}
{{- end -}}
{{- end -}}

{{- define "frigate.record" -}}
{{- $record := . }}
enabled: {{ ternary "True" "False" $record.enabled }}
{{- with $record.expire_interval }}
expire_interval: {{ . }}
{{- end -}}
{{- if $record.retain.render_config }}
retain:
  {{- if not (kindIs "invalid" $record.retain.days) }}
  days: {{ $record.retain.days }}
  {{- end -}}
  {{- with $record.retain.mode }}
  mode: {{ . }}
  {{- end -}}
{{- end -}}
{{- if $record.events.render_config }}
events:
  {{- if not (kindIs "invalid" $record.events.pre_capture) }}
  pre_capture: {{ $record.events.pre_capture }}
  {{- end -}}
  {{- if not (kindIs "invalid" $record.events.post_capture) }}
  post_capture: {{ $record.events.post_capture }}
  {{- end -}}
  {{- with $record.events.objects }}
  objects:
    {{- range $obj := . }}
    - {{ $obj }}
    {{- end -}}
  {{- end -}}
  {{- with $record.events.required_zones }}
  required_zones:
    {{- range $zone := . }}
    - {{ $zone }}
    {{- end -}}
  {{- end -}}
  {{- if $record.events.retain.render_config }}
  retain:
    default: {{ $record.events.retain.default | required "You need to provide default retain days" }}
    {{- with $record.events.retain.mode }}
    mode: {{ . }}
    {{- end -}}
    {{- with $record.events.retain.objects }}
    objects:
    {{- range $obj := . }}
      {{ $obj.object | required "You need to provide an object" }}: {{ $obj.days | required "You need to provide default retain days" }}
    {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.objects" -}}
{{- $objects := . -}}

{{- with $objects.track }}
track:
  {{- range $track := . }}
  - {{ $track }}
  {{- end -}}
{{- end -}}
{{- with $objects.mask }}
mask: {{ . }}
{{- end -}}
{{- with $objects.filters }}
filters:
  {{- range $filter := . }}
  {{ $filter.object | required "You need to provide an object" }}:
    {{- with $filter.min_area }}
    min_area: {{ . }}
    {{- end -}}
    {{- with $filter.max_area }}
    max_area: {{ . }}
    {{- end -}}
    {{- with $filter.min_ratio }}
    min_ratio: {{ . }}
    {{- end -}}
    {{- with $filter.max_ratio }}
    max_ratio: {{ . }}
    {{- end -}}
    {{- with $filter.min_score }}
    min_score: {{ . }}
    {{- end -}}
    {{- with $filter.threshold }}
    threshold: {{ . }}
    {{- end -}}
    {{- with $filter.mask }}
    mask: {{ . }}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.birdseye" -}}
{{- $birdseye := . }}
enabled: {{ ternary "True" "False" $birdseye.enabled }}
{{- with $birdseye.width }}
width: {{ . }}
{{- end -}}
{{- with $birdseye.height }}
height: {{ . }}
{{- end -}}
{{- with $birdseye.quality }}
quality: {{ . }}
{{- end -}}
{{- with $birdseye.mode }}
mode: {{ . }}
{{- end -}}
{{- end -}}

{{- define "frigate.timestamp_style" -}}
{{- $timestamp_style := . -}}

{{- with $timestamp_style.position }}
position: {{ . }}
{{- end -}}
{{- with $timestamp_style.format }}
format: {{ . }}
{{- end -}}
{{- if $timestamp_style.color.render_config }}
color:
  red: {{ $timestamp_style.color.red }}
  green: {{ $timestamp_style.color.green }}
  blue: {{ $timestamp_style.color.blue }}
{{- end -}}
{{- with $timestamp_style.thickness }}
thickness: {{ . }}
{{- end -}}
{{- with $timestamp_style.effect }}
effect: {{ $timestamp_style.effect }}
{{- end -}}
{{- end -}}

{{- define "frigate.live" -}}
{{- $live := . -}}
{{- with $live.height }}
height: {{ . }}
{{- end -}}
{{- with $live.quality }}
quality: {{ . }}
{{- end -}}
{{- end -}}

{{- define "frigate.rtmp" -}}
{{- $rtmp := . }}
enabled: {{ ternary "True" "False" $rtmp.enabled }}
{{- end -}}

{{- define "frigate.snapshots" -}}
{{- $snapshots := . }}
enabled: {{ ternary "True" "False" $snapshots.enabled }}
clean_copy: {{ ternary "True" "False" $snapshots.clean_copy }}
timestamp: {{ ternary "True" "False" $snapshots.timestamp }}
bounding_box: {{ ternary "True" "False" $snapshots.bounding_box }}
crop: {{ ternary "True" "False" $snapshots.crop }}
{{- with $snapshots.height }}
height: {{ . }}
{{- end -}}
{{- with $snapshots.required_zones }}
required_zones:
  {{- range $zone := . }}
  - {{ $zone }}
  {{- end -}}
{{- end -}}
{{- if $snapshots.retain.render_config }}
retain:
  default: {{ $snapshots.retain.default | required "You need to provide default retain days" }}
  {{- with $snapshots.retain.objects }}
  objects:
  {{- range $obj := . }}
    {{ $obj.object | required "You need to provide an object" }}: {{ $obj.days | required "You need to provide default retain days" }}
  {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.detectors" -}}
{{- $detectors := . -}}

{{- range $detector := $detectors.config }}
{{ $detector.name | required "You need to provide a detector name" }}:
  type: {{ $detector.type | required "You need to provide a detector type" }}
  {{- with $detector.device }}
  device: {{ . }}
  {{- end -}}
  {{- with $detector.num_threads }}
  num_threads: {{ . }}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.model" -}}
{{ $model := . }}
width: {{ $model.width | required "You need to provide a model width" }}
height: {{ $model.height | required "You need to provide a model height" }}
{{- with $model.path }}
path: {{ . }}
{{- end -}}
{{- with $model.labelmap_path }}
labelmap_path: {{ . }}
{{- end -}}
{{- with $model.labelmap }}
labelmap:
  {{- range $lmap := . }}
  {{ $lmap.model | required "You need to provide a labelmap model" }}: {{ $lmap.name | required "You need to provide a labelmap name" }}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.logger" -}}
{{- $logger := . }}
default: {{ $logger.default }}
{{- with $logger.logs }}
logs:
  {{- range $log := . }}
  {{ $log.component | required "You need to provide a logger cmponent" }}: {{ $log.verbosity | required "You need to provide logger verbosity" }}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "frigate.mqtt" -}}
{{- $mqtt := . }}
{{- if $mqtt.render_config }}
enabled: {{ ternary "True" "False" $mqtt.enabled }}
host: {{ required "You need to provide an MQTT host" $mqtt.host }}
{{- with $mqtt.port }}
port: {{ . }}
{{- end -}}
{{- with $mqtt.topic_prefix }}
topic_prefix: {{ . }}
{{- end -}}
{{- with $mqtt.client_id }}
client_id: {{ . }}
{{- end -}}
{{- if not (kindIs "invalid" $mqtt.stats_interval) }}
stats_interval: {{ $mqtt.stats_interval }}
{{- end -}}
{{- with $mqtt.user }}
user: {{ . }}
{{- end -}}
{{- with $mqtt.password }}
password: {{ . }}
{{- end -}}
{{- end -}}
{{- end -}}
