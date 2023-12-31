{{- range .Versions }}

## [{{ .Tag.Name }}]{{ if .Tag.Previous }}({{ $.Info.RepositoryURL }}/compare/{{ .Tag.Previous.Name }}...{{ .Tag.Name }}){{ else }}{{ .Tag.Name }}{{ end }} ({{ datetime "2006-01-02" .Tag.Date }})

{{- range .CommitGroups }}

### {{ .Title }}
  {{ range .Commits }}
- {{ .Subject -}}
  {{- end -}}

{{- end -}}

{{- range .NoteGroups }}

### {{ .Title }}
  {{ range .Notes }}
    {{- .Body }}
  {{- end }}
{{- end -}}

{{- end -}}
