{{/*
Validate list of host path in a specific format
*/}}
{{- define "common.storage.hostPathsValidation" -}}
    {{- $allowed_paths := (list "mnt" "sys" "dev" "cluster") -}}
    {{- range . -}}
        {{- $host_p := splitList "/" . -}}
        {{- $host_p := (without $host_p "") -}}
        {{- $error_msg := (printf "Invalid hostpath %s. Path must be a valid path under a given pool e.g `/mnt/tank/somepath` is valid whereas `/mnt` or `/mnt/tank` are invalid examples." .) -}}
        {{- if and (eq (index $host_p 0) "mnt") (lt ($host_p | len) 3) -}}
            {{- fail $error_msg -}}
        {{- else if (eq (index $host_p 0) "cluster") -}}
            {{- if (lt ($host_p | len) 2) -}}
                {{- fail $error_msg -}}
            {{- else if (eq (index $host_p 1) "ctdb_shared_vol") -}}
                {{- fail $error_msg -}}
            {{- end -}}
        {{- else if not (has (index $host_p 0) $allowed_paths) -}}
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
