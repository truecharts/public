{{/*
This template serves as a blueprint for all PersistentVolumeClaim objects that are created
within the common library.
*/}}
{{- define "common.classes.pvc" -}}
{{- $values := .Values.persistence -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.persistence -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $pvcName := include "common.names.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $pvcName = printf "%v-%v" $pvcName $values.nameOverride -}}
  {{ end -}}
{{ end }}
{{- if $values.forceName -}}
  {{- $pvcName = $values.forceName -}}
{{ end }}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $pvcName }}
  {{- if or $values.retain $values.annotations }}
  annotations:
    {{- if $values.retain }}
    "helm.sh/resource-policy": keep
    {{- end }}
    {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  labels:
  {{- include "common.labels" . | nindent 4 }}
  {{- with $values.labels }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  accessModes:
    - {{ ( $values.accessMode | default "ReadWriteOnce" ) | quote }}
  resources:
    requests:
      storage: {{ $values.size | default "999Gi" | quote }}
  {{- if $values.storageClass }}
  storageClassName: {{ if (eq "-" $values.storageClass) }}""{{- else if (eq "SCALE-ZFS" $values.storageClass ) }}{{ ( printf "%v-%v"  "ix-storage-class" .Release.Name ) }}{{- else }}{{ $values.storageClass | quote }}{{- end }}
  {{- else if or ( $.Values.global.isSCALE ) ( $.Values.ixChartContext ) ( $.Values.global.ixChartContext ) }}
  storageClassName: {{ ( printf "%v-%v"  "ix-storage-class" .Release.Name ) }}
  {{- end }}
  {{- if $values.volumeName }}
  volumeName: {{ $values.volumeName | quote }}
  {{- end }}
{{- end -}}
