{{/* Contains the auto-permissions job */}}
{{- define "tc.v1.common.lib.util.autoperms" -}}

{{- $permAllowedTypes := (list "hostPath" "emptyDir" "nfs") -}}
{{/* If you change this path, you must change it under _volumeMounts.tpl too*/}}
{{- $basePath := "/mounts" -}}

{{/* Init an empty dict to hold data */}}
{{- $mounts := dict -}}

{{/* Go over persistence and gather needed data */}}
{{- range $name, $mount := .Values.persistence -}}
  {{- if and $mount.enabled $mount.autoPermissions -}}
    {{/* If autoPermissions is enabled...*/}}
    {{- if $mount.autoPermissions.enabled -}}
      {{- if or $mount.autoPermissions.chown $mount.autoPermissions.chmod -}}
        {{- $type := $.Values.global.fallbackDefaults.persistenceType -}}
        {{- if $mount.type -}}
          {{- $type = $mount.type -}}
        {{- end -}}

        {{- if not (mustHas $type $permAllowedTypes) -}}
          {{- fail (printf "Auto Permissions - Allowed persistent types for auto permissions are [%v], but got [%v] on [%v]" (join ", " $permAllowedTypes) $type $name) -}}
        {{- end -}}

        {{- if $mount.readOnly -}}
          {{- fail (printf "Auto Permissions - You cannot change permissions/ownership automatically on [%v] with readOnly enabled" $name) -}}
        {{- end -}}

        {{/* Add some data regarding what actions to perform */}}
        {{- $_ := set $mounts $name $mount.autoPermissions -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- if $mounts }}
enabled: true
type: Job
annotations:
  "helm.sh/hook": pre-install, pre-upgrade
  "helm.sh/hook-weight": "3"
  "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
podSpec:
  restartPolicy: Never
  containers:
    # If you change this name, you must change it under _volumeMounts.tpl
    autopermissions:
      enabled: true
      primary: true
      imageSelector: alpineImage
      securityContext:
        runAsNonRoot: false
        runAsUser: 0
        capabilities:
          disableS6Caps: true
          add:
            - CHOWN
            - DAC_OVERRIDE
            - FOWNER
      resources:
        excludeExtra: true
        limits:
          cpu: 2000m
          memory: 2Gi
      probes:
        liveness:
          type: exec
          command:
            - cat
            - /tmp/healthy
        readiness:
          type: exec
          command:
            - cat
            - /tmp/healthy
        startup:
          type: exec
          command:
            - cat
            - /tmp/healthy
      command:
        - /bin/sh
        - -c
      args:
        - |
          echo "Starting auto permissions job..."
          touch /tmp/healthy

          echo "Automatically correcting ownership and permissions..."

          {{- range $name, $vol := $mounts }}
            {{- $mountPath := (printf "%v/%v" $basePath $name) -}}

            {{- $user := "" -}}
            {{- if $vol.user -}}
              {{- $user = $vol.user -}}
            {{- end -}}

            {{- $group := $.Values.securityContext.pod.fsGroup -}}
            {{- if $vol.group -}}
              {{- $group = $vol.group -}}
            {{- end -}}

            {{- $r := "" -}}
            {{- if $vol.recursive -}}
              {{- $r = "-R" -}}
            {{- end -}}

            {{/* Permissions */}}
            {{- if $vol.chmod }}
              echo "Automatically correcting permissions for {{ $mountPath }}..."
              before=$(stat -c "%a" {{ $mountPath }})
              chmod {{ $r }} {{ $vol.chmod }} {{ $mountPath }} || echo "Failed setting permissions using chmod..."
              echo "Permissions before: [$before]"
              echo "Permissions after: [$(stat -c "%a" {{ $mountPath }})]"
              echo ""
            {{- end -}}

            {{/* Ownership */}}
            {{- if $vol.chown }}
              echo "Automatically correcting ownership for {{ $mountPath }}..."
              before=$(stat -c "%u:%g" {{ $mountPath }})
              chown {{ $r }} -f {{ $user }}:{{ $group }} {{ $mountPath }} || echo "Failed setting ownership using chown..."

              echo "Ownership before: [$before]"
              echo "Ownership after: [$(stat -c "%u:%g" {{ $mountPath }})]"
              echo ""
            {{- end -}}
          {{- end }}
          echo "Finished auto permissions job..."
{{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.util.autoperms.job" -}}
  {{- $job := (include "tc.v1.common.lib.util.autoperms" $) | fromYaml -}}
  {{- if $job -}}
    # If you change this name, you must change it under _volumes.tpl
    {{- $_ := set $.Values.workload "autopermissions" $job -}}
  {{- end -}}
{{- end -}}
