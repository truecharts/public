{{- define "externaldns.args" -}}
args:
  {{- with .Values.externaldns.provider }}
  - --provider={{ . }}
  {{- end -}}
  {{- range .Values.externaldns.zoneidFilters }}
  - --zone-id-filter={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.cloudflareProxied }}
  - --cloudflare-proxied={{ . }}
  {{- end }}
  - --log-level={{ .Values.externaldns.logLevel }}
  - --log-format={{ .Values.externaldns.logFormat }}
  - --interval={{ .Values.externaldns.interval }}
  {{- if .Values.externaldns.triggerLoopOnEvent }}
  - --events
  {{- end -}}
  {{- range .Values.externaldns.sources }}
  - --source={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.policy }}
  - --policy={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.registry }}
  - --registry={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.txtOwnerId }}
  - --txt-owner-id={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.txtPrefix }}
  - --txt-prefix={{ . }}
  {{- end -}}
  {{- if and (eq .Values.externaldns.txtPrefix "") (ne .Values.externaldns.txtSuffix "") }}
  - --txt-suffix={{ .Values.externaldns.txtSuffix }}
  {{- end -}}
  {{- if .Values.externaldns.namespaced }}
  - --namespace={{ include "tc.v1.common.lib.metadata.namespace" (dict "caller" "External-DNS" "rootCtx" $ "objectData" .Values) }}
  {{- end -}}
  {{- range .Values.externaldns.domainFilters }}
  - --domain-filter={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.piholeServer }}
  - --pihole-server={{ . }}
  {{- end -}}
  {{- with .Values.externaldns.piholePassword }}
  - --pihole-password={{ . }}
  {{- end -}}
{{- end -}}
