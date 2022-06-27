{{/* Calculate PHP and NGINX file size limits from PrivateBin configuration */}}
{{- define "privatebin.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-config
data:
  sizelimits-php.ini: |-
    upload_max_filesize = {{ .Values.privatebin.main.sizelimit }}
    post_max_size = {{ .Values.privatebin.main.sizelimit }}
    memory_limit = {{ mul .Values.privatebin.main.sizelimit 2 }}
  sizelimits-nginx.conf: |-
    client_max_body_size {{ add (div (div .Values.privatebin.main.sizelimit 1024) 1024) 5 }}M;

{{- end }}
