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
  - name: ix-host-volume-{{ $.Release.Name }}-{{ $index }}
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
  {{- range $index, $hostPathConfiguration := .Values.ixVolumes }}
  - mountPath: {{ $hostPathConfiguration.mountPath }}
    name: ix-host-volume-{{ $.Release.Name }}-{{ $index }}
  {{- end }}
{{- end }}
{{- end }}
