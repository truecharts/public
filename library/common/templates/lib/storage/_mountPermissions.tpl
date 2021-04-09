{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.storage.permissions" -}}
{{- if .Values.fixMountPermissions }}

{{- if .Values.appVolumeMounts }}
{{- range $name, $vm := .Values.appVolumeMounts -}}
{{- if and $vm.enabled $vm.setPermissions}}
{{- print "---" | nindent 0 -}}

{{- $VMValues := $vm -}}
{{- if not $VMValues.nameSuffix -}}
  {{- $_ := set $VMValues "nameSuffix" $name -}}
{{ end -}}
{{- $_ := set $ "ObjectValues" (dict "appVolumeMounts" $VMValues) -}}

{{ include "common.storage.permissions.job" $  | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}


{{- if .Values.additionalAppVolumeMounts }}
{{- range $index, $avm := .Values.additionalAppVolumeMounts -}}
{{- if and $avm.enabled $avm.setPermissions}}
{{- print "---" | nindent 0 -}}

{{- $AVMValues := $avm -}}
{{- if not $AVMValues.nameSuffix -}}
  {{- $_ := set $AVMValues "nameSuffix" $index -}}
{{ end -}}
{{- $_ := set $ "ObjectValues" (dict "appVolumeMounts" $AVMValues) -}}

{{ include "common.storage.permissions.job" $  | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}

{{- end }}
{{- end }}
