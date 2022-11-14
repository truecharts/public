{{- define "ix.v1.common.container.fixedEnvs" -}}
- name: TZ
  value: {{ tpl (toYaml .Values.TZ) $ | quote }}
- name: UMASK
  value: {{ tpl (toYaml .Values.security.UMASK) $ | quote }}
- name: UMASK_SET
  value: {{ tpl (toYaml .Values.security.UMASK) $ | quote }}
{{- if not (.Values.scaleGPU) }}
- name: NVIDIA_VISIBLE_DEVICES
  value: "void"
{{- else }}
- name: NVIDIA_DRIVER_CAPABILITIES
  value: {{ join "," .Values.nvidiaCaps | quote }}
{{- end -}}
{{- if and (or (not .Values.podSecurityContext.runAsUser) (not .Values.podSecurityContext.runAsGroup))  (or .Values.security.PUID (eq (.Values.security.PUID | int) 0)) }} {{/* If root user or root group and a PUID is set, set PUID and related envs */}}
- name: PUID
  value: {{ tpl (toYaml .Values.security.PUID) $ | quote }}
- name: USER_ID
  value: {{ tpl (toYaml .Values.security.PUID) $ | quote }}
- name: UID
  value: {{ tpl (toYaml .Values.security.PUID) $ | quote }}
- name: PGID
  value: {{ tpl (toYaml .Values.podSecurityContext.fsGroup) $ | quote }}
- name: GROUP_ID
  value: {{ tpl (toYaml .Values.podSecurityContext.fsGroup) $ | quote }}
- name: GID
  value: {{ tpl (toYaml .Values.podSecurityContext.fsGroup) $ | quote }}
{{- end -}}
{{- if or (.Values.securityContext.readOnlyRootFilesystem) (.Values.securityContext.runAsNonRoot) }} {{/* Mainly for LSIO containers, tell S6 to avoid using rootfs */}}
- name: S6_READ_ONLY_ROOT
  value: "1"
{{- end -}}
{{- end -}}
