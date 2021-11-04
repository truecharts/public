{{/*
Volumes Configuration
*/}}
{{- define "volumeConfiguration" }}
{{- if or .Values.ixVolumes .Values.hostPathVolumes .Values.emptyDirVolumes }}
volumes:
{{- range $index, $hostPathConfiguration := .Values.hostPathVolumes }}
  - name: ix-host-path-{{ $.Release.Name }}-{{ $index }}
    hostPath:
      path: {{ $hostPathConfiguration.hostPath }}
{{- end }}
{{- range $index, $hostPathConfiguration := .Values.ixVolumes }}
{{ $dsName := base $hostPathConfiguration.hostPath }}
  - name: ix-host-volume-{{ $.Release.Name }}-{{ $dsName }}
    hostPath:
      path: {{ $hostPathConfiguration.hostPath }}
{{- end }}
{{- range $index, $emptyDirConfiguration := .Values.emptyDirVolumes }}
  - name: ix-emptydir-volume-{{ $.Release.Name }}-{{ $index }}
    emptyDir:
      medium: Memory
{{- end }}
{{- end }}
{{- end }}


{{/*
Volume Mounts Configuration
*/}}
{{- define "volumeMountsConfiguration" }}
{{- if or .Values.hostPathVolumes .Values.ixVolumes .Values.emptyDirVolumes }}
volumeMounts:
  {{- range $index, $hostPathConfiguration := .Values.hostPathVolumes }}
  - mountPath: {{ $hostPathConfiguration.mountPath }}
    name: ix-host-path-{{ $.Release.Name }}-{{ $index }}
    readOnly: {{ $hostPathConfiguration.readOnly }}
  {{- end }}
  {{- range $index, $hostPathConfiguration := .Values.volumes }}
  - mountPath: {{ $hostPathConfiguration.mountPath }}
    name: ix-host-volume-{{ $.Release.Name }}-{{ $hostPathConfiguration.datasetName }}
  {{- end }}
  {{- range $index, $emptyDirConfiguration := .Values.emptyDirVolumes }}
  - mountPath: {{ $emptyDirConfiguration.mountPath }}
    name: ix-emptydir-volume-{{ $.Release.Name }}-{{ $index }}
  {{- end }}
{{- end }}
{{- end }}
