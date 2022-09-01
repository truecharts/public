{{/* Define the nginx container */}}
{{- define "inventree.nginx" -}}
image: {{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}
imagePullPolicy: '{{ .Values.nginxImage.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
ports:
  - containerPort: {{ .Values.service.main.ports.main.port }}
    name: main
volumeMounts:
  - name: inventree-nginx
    mountPath: "/etc/nginx/conf.d/default.conf"
    subPath: default.conf
    readOnly: true
  - name: data
    mountPath: "/var/www"
{{- end -}}
