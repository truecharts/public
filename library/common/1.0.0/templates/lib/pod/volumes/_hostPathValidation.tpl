{{- define "ix.v1.common.controller.volumes.hostPath.validation" -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- $validate := $root.Values.global.defaults.validateHostPath -}}
  W
  {{- if (hasKey $vol "validateHostPath") -}}
    {{- $validate = $vol.validateHostPath -}}
  {{- end -}}
  {{- if $validate -}}
    {{- $allowed_paths := (list "mnt" "sys" "dev" "cluster") -}}
    {{- $errorMessage := (printf "Invalid hostPath (%s). Allowed hostPaths are valid paths under a given pool. e.g. /mnt/POOL/DATASET, /mnt/POOL/DATASET/DIRECTORY" $vol.hostPath) -}}
    {{- $hostPath := splitList "/" $vol.hostPath -}} {{/* Split the path into a list */}}
    {{- $hostPath := (mustWithout $hostPath "") -}} {{/* Drop any list items with empty strings */}}
    {{- $pathStart := (index $hostPath 0) -}}
    {{- if not (mustHas $pathStart $allowed_paths) -}}
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

{{- define "ix.v1.common.controller.hostPathType.validation" -}}
  {{- $type := .type -}}
  {{- $index := .index -}}
  {{- if not (mustHas $type (list "DirectoryOrCreate" "Directory" "FileOrCreate" "File" "Socket" "CharDevice" "BlockDevice")) -}}
    {{- fail (printf "Invalid <hostPathType> option (%s) on item (%s). Valid options are DirectoryOrCreate, Directory, FileOrCreate, File, Socket, CharDevice and BlockDevice" $type $index) -}}
  {{- end -}}
{{- end -}}
