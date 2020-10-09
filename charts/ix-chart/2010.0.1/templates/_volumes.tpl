{{/*
Volumes Configuration
*/}}
{{- define "volumeConfiguration" }}
{{- if or (or .Values.persistentVolumeClaims .Values.hostPathVolumes) .Values.ixVolumes }}
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
{{- range $index, $claim := .Values.persistentVolumeClaims }}
  - name: ix-pv-{{ $claim.name }}
    persistentVolumeClaim:
      claimName: ix-{{ $claim.name }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Volume Mounts Configuration
*/}}
{{- define "volumeMountsConfiguration" }}
{{- if or .Values.hostPathVolumes .Values.persistentVolumeClaims }}
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
  {{- range $index, $claim := .Values.persistentVolumeClaims }}
  - mountPath: {{ $claim.mountPath }}
    name: ix-pv-{{ $claim.name }}
  {{- end }}
{{- end }}
{{- end }}
