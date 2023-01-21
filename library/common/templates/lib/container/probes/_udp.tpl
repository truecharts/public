{{/* Returns udp for the probe */}}
{{- define "ix.v1.common.container.probes.udp" -}}
  {{- $containerName := .containerName -}}
  {{- fail (printf "UDP Probes are not supported. Please use a different probe type or disable probes in (%s) container." $containerName) -}}
{{- end -}}
