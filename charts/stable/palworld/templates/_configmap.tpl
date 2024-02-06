{{/* Define the configmap */}}
{{- define "palworld.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $adminPassword := .Values.palworld.game.admin_password -}}
{{- $rconPort := .Values.service.rcon.ports.rcon.port }}
{{- $rcon := .Values.palworld.rcon }}

palworld-rcon:
  enabled: true
  data:
    rcon.yaml: |
     default:
       address: "{{ printf "%v-rcon:%v" $fullname $rconPort }}"
       password: {{ $adminPassword }}
       log: "rcon-palworld.log"
       timeout: "{{ $rcon.timeout }}"
{{- end -}}
