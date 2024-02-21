{{/* Define the configmap */}}
{{- define "pihole.configmap" -}}
configmap:
  pihole-env:
    enabled: true
    data:
      WEBPASSWORD: {{ .Values.pihole.webPassword | quote }}
      {{- with .Values.pihole.dnsServers }}
        {{- if gt (len .) 2 -}}
          {{- fail (printf "Pihole - Expected max 2 DNS Servers. But got [%v]" (len .)) -}}
        {{- end }}
      PIHOLE_DNS_: {{ join ";" . | quote }}
      {{- end }}
{{- end -}}
