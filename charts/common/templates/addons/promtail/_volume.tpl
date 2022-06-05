{{/*
The volume (referencing config) to be inserted into additionalVolumes.
*/}}
{{- define "tc.common.addon.promtail.volumeSpec" -}}
configMap:
  name: {{ include "tc.common.names.fullname" . }}-promtail
{{- end -}}
