{{/*
Volumes Configuration
*/}}
{{- define "volumeConfiguration" }}
{{- if or .Values.persistentVolumeClaims .Values.hostPathVolumes }}
volumes:
{{- range $index, $hostPathConfiguration := .Values.hostPathVolumes }}
  - name: ix-host-path-{{ $.Release.Name }}-{{ $index }}
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
  {{- range $index, $claim := .Values.persistentVolumeClaims }}
  - mountPath: {{ $claim.mountPath }}
    name: ix-pv-{{ $claim.name }}
  {{- end }}
{{- end }}
{{- end }}
