{{- define "ix.v1.common.controller.volumes.hostPath.validation" -}}
  {{- if $root.Values.global.defaults.validateHostPaths -}} {{/* TODO: global or per volume flag? */}}
    {{- $incomingData := .incoming -}} {{/* TODO: change variable name... temp implementation */}}
    {{- $allowed_paths := (list "mnt" "sys" "dev" "cluster") -}}
    {{- $errorMessage := (printf "Invalid hostPath (%s). Allowed hostPaths are valid paths under a given pool. e.g. /mnt/POOL/DATASET, /mnt/POOL/DATASET/DIRECTORY" $incomingData) -}}
    {{- $hostPath := splitList "/" $incomingData -}} {{/* Split the path into a list */}}
    {{- $hostPath := (mustWithout $hostPath "") -}} {{/* Drop any list items with empty strings */}}
    {{- $pathStart := (index $hostPath 0) -}}
    {{- if not (mustHas ($pathStart $allowed_paths)) -}}
      {{- fail $errorMessage -}}
    {{- else if eq $pathStart "mnt" -}}
      {{- if lt (len $hostPath) 3 -}}
        {{- fail $errorMessage -}}
      {{- end -}}
    {{- else if eq $pathStart "cluster" -}}
      {{- if lt (len $hostPath) 2 -}}
        {{- fail $errorMessage -}}
      {{- else if eq (index $hostPath 1) "ctdb_shared_vol" -}}
        {{- fail $errorMessage -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{/* TODO: unittests */}}
