{{/*
Volumes Configuration
*/}}
{{- define "volumeConfiguration" }}
{{- if or .Values.ixVolumes .Values.hostPathVolumes }}
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
{{- end }}
{{- end }}


{{/*
Volume Mounts Configuration
*/}}
{{- define "volumeMountsConfiguration" }}
{{- if or .Values.hostPathVolumes .Values.ixVolumes }}
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
{{- end }}
{{- end }}
