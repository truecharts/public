{{- define "externaldns.args" -}}
args:
            {{- with .Values.externaldns.provider }}
            - --provider={{ . }}
            {{- end }}
            {{- with .Values.externaldns.zoneidfilter }}
            - --zone-id-filter={{ . }}
            {{- end }}
            {{- with .Values.externaldns.cloudflareproxied }}
            - --cloudflare-proxied={{ tpl . $ }}
            {{- end }}
            - --log-level={{ .Values.externaldns.logLevel }}
            - --log-format={{ .Values.externaldns.logFormat }}
            - --interval={{ .Values.externaldns.interval }}
            {{- if .Values.externaldns.triggerLoopOnEvent }}
            - --events
            {{- end }}
            {{- range .Values.externaldns.sources }}
            - --source={{ . }}
            {{- end }}
            {{- with .Values.externaldns.policy }}
            - --policy={{ . }}
            {{- end }}
            {{- with .Values.externaldns.registry }}
            - --registry={{ . }}
            {{- end }}
            {{- if .Values.externaldns.txtOwnerId }}
            - --txt-owner-id={{ .Values.externaldns.txtOwnerId }}
            {{- end }}
            {{- if .Values.externaldns.txtPrefix }}
            - --txt-prefix={{ .Values.externaldns.txtPrefix }}
            {{- end }}
            {{- if and (eq .Values.externaldns.txtPrefix "") (ne .Values.externaldns.txtSuffix "") }}
            - --txt-suffix={{ .Values.externaldns.txtSuffix }}
            {{- end }}
            {{- if .Values.externaldns.namespaced }}
            - --namespace={{ .Release.externaldns.Namespace }}
            {{- end }}
            {{- range .Values.externaldns.domainFilters }}
            - --domain-filter={{ . }}
            {{- end }}
            {{- with .Values.externaldns.piholeserver }}
            - --pihole-server={{ . }}
            {{- end }}
            {{- with .Values.externaldns.piholepassword }}
            - --pihole-password={{ . }}
            {{- end }}
{{- end -}}
