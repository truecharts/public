{{/*
Validate list of host path in a specific format
*/}}
{{- define "common.storage.hostPathsValidation" -}}
    {{- range . -}}
        {{- $host_p := splitList "/" . -}}
        {{- $host_p := (without $host_p "") -}}
        {{- $error_msg := (printf "Invalid hostpath %s. Path must be a valid path under a given pool e.g `/mnt/tank/somepath` is valid whereas `/mnt` or `/mnt/tank` are invalid examples." .) -}}
        {{- if lt ($host_p | len) 3 -}}
            {{- fail $error_msg -}}
        {{- else if ne (index $host_p 0) "mnt" -}}
            {{- fail $error_msg -}}
        {{- end -}}
    {{- end -}}
{{- end -}}


{{/*
Validate app volume mount's host path
*/}}
{{- define "common.storage.appHostPathsValidate" -}}
    {{- $host_p := list -}}
    {{- range $path_name := .appVolumeMounts -}}
        {{- if ($path_name.hostPathEnabled) -}}
            {{- $host_p = mustAppend $host_p $path_name.hostPath -}}
        {{- end -}}
    {{- end -}}
    {{- include "common.storage.hostPathsValidation" $host_p -}}
{{- end -}}


{{/*
Validate extra volume mount's host path
*/}}
{{- define "common.storage.extraHostPathsValidate" -}}
    {{- $host_p := list -}}
    {{- range $index, $hostPathConfiguration := .extraAppVolumeMounts -}}
        {{- $host_p = mustAppend $host_p $hostPathConfiguration.hostPath -}}
    {{- end -}}
    {{- include "common.storage.hostPathsValidation" $host_p -}}
{{- end -}}


{{/*
Validate volumes mount's host paths
*/}}
{{- define "common.storage.hostPathValidate" -}}
    {{- include "common.storage.extraHostPathsValidate" . -}}
    {{- include "common.storage.appHostPathsValidate" . -}}
{{- end -}}
