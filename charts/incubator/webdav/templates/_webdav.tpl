{{- define "webdav.workload" -}}
workload:
  main:
    enabled: true
    primary: true
    type: Deployment
    podSpec:
      containers:
        main:
          imageSelector: image
          envList:
          probes:
            liveness:
              enabled: true
              type: {{ $scheme }}
              path: /health
              port: {{ $port }}
            {{ if eq .Values.webdavConfig.authType "basic" }}
              httpHeaders:
                Authorization: Basic {{ (printf "%s:%s" .Values.webdavConfig.username .Values.webdavConfig.password) | b64enc }}
            {{ end }}
            readiness:
              enabled: true
              type: {{ $scheme }}
              path: /health
              port: {{ $port }}
            {{ if eq .Values.webdavConfig.authType "basic" }}
              httpHeaders:
                Authorization: Basic {{ (printf "%s:%s" .Values.webdavConfig.username .Values.webdavConfig.password) | b64enc }}
            {{ end }}
            startup:
              enabled: true
              type: {{ $scheme }}
              path: /health
              port: {{ $port }}
            {{ if eq .Values.webdavConfig.authType "basic" }}
              httpHeaders:
                Authorization: Basic {{ (printf "%s:%s" .Values.webdavConfig.username .Values.webdavConfig.password) | b64enc }}
            {{ end }}
{{- end -}}
