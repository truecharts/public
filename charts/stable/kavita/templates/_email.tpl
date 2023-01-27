{{/* Define the email container */}}
{{- define "kavita.email" -}}
image: {{ .Values.emailImage.repository }}:{{ .Values.emailImage.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 0
  runAsGroup: 0
  readOnlyRootFilesystem: false
  runAsNonRoot: false
ports:
  - containerPort: "{{ .Values.service.backend.ports.main.email }}"
env:
  - name: 'SMTP_USER'
    value: '{{ .Values.kavita.smtp_user }}'
  - name: 'SMTP_PASS'
    value: '{{ .Values.kavita.smtp_pass }}'
  - name: 'SMTP_HOST'
    value: '{{ .Values.kavita.smtp_host }}'
  - name: 'SMTP_PASS'
    value: '{{ .Values.kavita.smtp_pass }}'
  - name: 'SMTP_PORT'
    value: '{{ .Values.kavita.smtp_port }}'
  - name: 'SEND_ADDR'
    value: '{{ .Values.kavita.send_addr }}'
  - name: 'DISP_NAME'
    value: '{{ .Values.kavita.disp_name }}'
{{- end -}}
