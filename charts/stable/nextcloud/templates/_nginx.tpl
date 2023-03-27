{{/* Define the nginx container */}}
{{- define "nextcloud.nginx" -}}
enabled: true
imageSelector: nginxImage
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 33
  runAsGroup: 33
  readOnlyRootFilesystem: true
probes:
  readiness:
    path: /robots.txt
    port: 8080
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  liveness:
    path: /robots.txt
    port: 8080
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  startup:
    path: /robots.txt
    port: 8080
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
{{- end -}}
