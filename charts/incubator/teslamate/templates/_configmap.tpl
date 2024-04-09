{{/* Define the configmap */}}
{{- define "teslamate.configmaps" -}}
{{- $rootDir := "dashboards/" -}}
{{- $dirs := dict -}}
{{- range $path, $_ := .Files.Glob (printf "%s**/*.json" $rootDir) }}
  {{- $pathElements := splitList "/" $path -}}
  {{- $dirName := index $pathElements 1 }} # Assuming the directory name is the second element
  {{- $existingFiles := get $dirs $dirName -}}
  {{- if not $existingFiles }}
    {{- $existingFiles = list -}}
  {{- end }}
  {{- $updatedFiles := append $existingFiles $path -}}
  {{- $_ := set $dirs $dirName $updatedFiles }}
{{- end }}

{{- range $dir, $files := $dirs }}
{{- range $files }}
{{- $fileName := base . }}
{{ printf "%s-%s-%s" "dashboard" $dir $fileName | quote }}:
  enabled: true
  annotations:
    k8s-sidecar-target-directory: "TeslaMate"
  labels:
      grafana_dashboard: "1"
  data:
    {{ $fileName | quote }}: |
{{ $.Files.Get . | indent 6 }}
{{- end -}}
{{- end -}}
{{- end -}}
