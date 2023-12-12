{{/* Calculate PHP and NGINX file size limits from PrivateBin configuration */}}
{{- define "privatebin.configmap" -}}
enabled: true
data:
  {{/*
    Multiply by 1, so large integers aren't rendered in scientific notation
    See: https://github.com/helm/helm/issues/1707#issuecomment-1167860346
  */}}
  sizelimits-php.ini: |-
    upload_max_filesize = {{ mul .Values.privatebin.main.sizelimit 1 }}
    post_max_size = {{ mul .Values.privatebin.main.sizelimit 1 }}
    memory_limit = {{ mul .Values.privatebin.main.sizelimit 2 }}
  sizelimits-nginx.conf: |-
    client_max_body_size {{ add (div (div .Values.privatebin.main.sizelimit 1024) 1024) 5 }}M;

{{- end }}
