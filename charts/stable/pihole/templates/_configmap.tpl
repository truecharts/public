{{/* Define the configmap */}}
{{- define "pihole.configmap" -}}
configmap:
  pihole-env:
    enabled: true
    data:
      FTLCONF_webserver_api_password: {{ .Values.pihole.webPassword | quote }}
      {{- with .Values.pihole.dnsServers }}
        {{- if gt (len .) 2 -}}
          {{- fail (printf "Pihole - Expected max 2 DNS Servers. But got [%v]" (len .)) -}}
        {{- end }}
      FTLCONF_dns_upstreams: {{ join ";" . | quote }}
      {{- end }}
{{- end -}}
