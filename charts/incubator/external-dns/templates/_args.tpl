{{- define "externaldns.args" -}}
args:
  {{- with .Values.externaldns.source1 }}
  - --source={{ . }}
  {{- end }}
  {{- with .Values.externaldns.source2 }}
  - --source={{ . }}
  {{- end }}
  {{- with .Values.externaldns.domainfilter }}
  - --domain-filter={{ . }}
  {{- end }}
  {{- with .Values.externaldns.provider }}
  - --provider={{ . }}
  {{- end }}
  {{- with .Values.externaldns.zoneidfilter }}
  - --zone-id-filter={{ . }}
  {{- end }}
  {{- with .Values.externaldns.cloudflareproxied }}
  - --cloudflare-proxied={{ . }}
  {{- end }}
  {{- with .Values.externaldns.registry }}
  - --registry={{ . }}
  {{- end }}
  {{- with .Values.externaldns.policy }}
  - --policy={{ . }}
  {{- end }}
  {{- with .Values.externaldns.piholeserver }}
  - --pihole-server={{ . }}
  {{- end }}
  {{- with .Values.externaldns.piholepassword }}
  - --pihole-password={{ . }}
  {{- end }}
  {{- end }}
{{- end -}}
