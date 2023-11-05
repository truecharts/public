{{- define "external-dns.args" -}}
args:
  {{- with .Values.external-dns.source1 }}
  - --source
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.source2 }}
  - --source
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.domain-filter }}
  - --domain-filter
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.provider }}
  - --provider
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.cloudflare-proxied }}
  - --cloudflare-proxied
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.registry }}
  - --registry
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.policy }}
  - --policy
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.pihole-server }}
  - --pihole-server
  - {{ . }}
  {{- end }}
  {{- with .Values.external-dns.pihole-password }}
  - --pihole-password
  - {{ . }}
  {{- end }}
  {{- end }}
{{- end -}}
