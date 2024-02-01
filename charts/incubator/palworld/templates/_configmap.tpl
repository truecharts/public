{{/* Define the configmap */}}
{{- define "odoo.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $rconPath := .Values.persistence.serverfiles.targetSelector.rcon.rcon.mountPath -}}
{{- $adminPassword := .Values.palworld.game.admin_password -}}
{{- $rconPort := .Values.service.rcon.ports.rcon.port -}}

palworld-rcon:
  enabled: true
  data:
    rcon.yaml: |
     default:
       address: "{{ printf "%v-rcon:%v" $fullname $rconPort }}"
       password: {{ $adminPassword }}
       log: "{{ $rconPath }}/rcon.log"
{{- end -}}
