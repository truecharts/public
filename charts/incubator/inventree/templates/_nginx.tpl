{{/* Define the nginx container */}}
{{- define "inventree.nginx" -}}
image: {{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}
imagePullPolicy: {{ .Values.nginxImage.pullPolicy }}
ports:
  - containerPort: {{ .Values.service.main.ports.main.port }}
    name: main
securityContext:
  runAsUser: 0
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: false
  runAsNonRoot: false
volumeMounts:
  - name: inventree-nginx
    mountPath: "/etc/nginx/conf.d/default.conf"
    subPath: default.conf
    readOnly: true
  - name: data
    mountPath: "/var/www"
{{- end -}}
