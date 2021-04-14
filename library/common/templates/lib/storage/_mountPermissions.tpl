{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.storage.permissions" -}}
{{- if .Values.fixMountPermissions }}

{{- range $index, $avm := .Values.customStorage -}}
{{- if and $avm.enabled $avm.setPermissions}}
{{- print "---" | nindent 0 -}}

{{- $AVMValues := $avm -}}
{{- if not $AVMValues.nameSuffix -}}
  {{- $_ := set $AVMValues "nameSuffix" $index -}}
{{ end -}}
{{- $_ := set $ "ObjectValues" (dict "appVolumeMounts" $AVMValues) -}}

{{ include "common.storage.permissions.job" $  | nindent 0 }}


{{- $values := .Values.appVolumeMounts -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.appVolumeMounts -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $JobName := include "common.names.fullname" . -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $JobName = printf "%v-%v" $JobName $values.nameSuffix -}}
{{ end -}}

apiVersion: batch/v1
kind: Job
metadata:
  name: {{ $JobName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
    {{- with .Values.controllerLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  annotations:
   "helm.sh/hook": pre-install,pre-upgrade
   "helm.sh/hook-weight": "-10"
   "helm.sh/hook-delete-policy": hook-succeeded,hook-failed,before-hook-creation
  {{- with .Values.controllerAnnotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
      {{- include "common.labels.selectorLabels" . | nindent 8 }}
    spec:
      restartPolicy: Never
      containers:
        - name: set-mount-permissions
          image: "alpine:3.3"
          command:
          - /bin/sh
          - -c
          - |
            chown -R{{ if eq .podSecurityContext.runAsNonRoot false }}{{ print .Values.PUID }}:{{ print .Values.PGID }}{{ else }}{{ print .podSecurityContext.runAsUser }}:{{ print .podSecurityContext.fsGroup }}{{ end }}{{ print $values.mountPath }}
          #args:
          #
          #securityContext:
          #
          volumeMounts:
            {{- include "common.controller.volumeMounts" . | indent 12 }}
      {{- with (include "common.controller.volumes" . | trim) }}
      volumes:
        {{- . | nindent 8 }}
      {{- end }}


{{- end }}
{{- end }}


{{- end }}
{{- end }}
