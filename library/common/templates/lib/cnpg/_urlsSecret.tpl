{{- define "tc.v1.common.lib.cnpg.secret.urls" -}}
{{- $std := .std }}
{{- $nossl := .nossl }}
{{- $porthost := .porthost }}
{{- $host := .host }}
{{- $jdbc := .jdbc }}
enabled: true
data:
  std: {{ $std }}
  nossl: {{ $nossl }}
  porthost: {{ $porthost }}
  host: {{ $host }}
  jdbc: {{ $jdbc }}
{{- end -}}
