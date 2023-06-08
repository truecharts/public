{{/* Define the nginx container */}}
{{- define "wger.nginx" -}}
image: {{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}
imagePullPolicy: {{ .Values.nginxImage.pullPolicy }}
ports:
  - containerPort: {{ .Values.service.main.ports.main.port }}
    name: main
securityContext:
  runAsUser: 0
  runAsGroup: 1000
  readOnlyRootFilesystem: false
  runAsNonRoot: false
volumeMounts:
  - name: wger-config
    mountPath: "/etc/nginx/conf.d/default.conf"
    subPath: default.conf
    readOnly: true
  - name: media
    mountPath: "/media"
  - name: static
    mountPath: "/static"
{{- end -}}
