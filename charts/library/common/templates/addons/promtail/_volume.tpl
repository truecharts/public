{{/*
The volume (referencing config) to be inserted into additionalVolumes.
*/}}
{{- define "common.addon.promtail.volumeSpec" -}}
configMap:
  name: {{ include "common.names.fullname" . }}-promtail
{{- end -}}
