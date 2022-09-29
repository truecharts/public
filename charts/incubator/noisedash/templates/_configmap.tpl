{{/* Define the secrets */}}
{{- define "noisedash.config" -}}
{{- $configName := printf "%s-noisedash-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  default.json: |
    {
      "Server": {
        "listeningPort": {{ .Values.service.main.ports.main.port }},
        "sessionFileStorePath": "sessions",
        "sampleUploadPath": "/var/noisedash/samples",
        "maxSampleSize": {{ int .Values.noisedash.max_sample_size_in_bytes }},
        "logFile": "/var/noisedash/log/log/noisedash.log",
        "tls": false,
        "tlsKey": "certs/key.pem",
        "tlsCert": "certs/cert.pem"
      }
    }
{{- end -}}
