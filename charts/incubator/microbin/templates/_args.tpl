{{- define "microbin.args" -}}
{{ $v := .Values.microbin }}
args:
  - port
  - "{{ .Values.service.main.ports.main.port }}"
  {{- if $v.editable }}
  - --editable
  {{- end }}
  {{- if $v.hide_logo }}
  - --hide-logo
  {{- end }}
  {{- if $v.hide_header }}
  - --hide-header
  {{- end }}
  {{- if not $v.hide_footer }}
  {{- with $v.footer }}
  - --footer_text
  - "{{ . }}"
  {{- end }}
  {{- else }}
  - --hide-footer
  {{- end }}
  {{- if $v.no_listing }}
  - --no-listing
  {{- end }}
  {{- if $v.syntax_highlight }}
  - --highlightsyntax
  {{- end }}
  {{- if $v.private }}
  - --private
  {{- end }}
  {{- if $v.pure_html }}
  - --pure-html
  {{- end }}
  {{- if $v.read_only }}
  - --readonly
  {{- end }}
  {{- with $v.title }}
  - --title
  - "{{ . }}"
  {{- end }}
  {{- if $v.wide }}
  - --wide
  {{- end }}
  {{- with $v.threads }}
  - --threads
  - {{ . }}
  {{- end }}
  {{- if $v.username }}
  - --auth-username
  - "{{ $v.username }}"
  {{- if $v.password }}
  - --auth-password
  - "{{ $v.password }}"
  {{- end }}
  {{- end }}

{{- end -}}
