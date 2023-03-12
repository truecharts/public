{{/* Define the init container */}}
{{- define "inventree.init" -}}
enabled: true
imageSelector: image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
command: ["sh", "-c"]
args:
  - |-
    echo "Starting initialization..."
    cd /home/inventree || exit
    invoke update
    echo "Initialization finished!"
envFrom:
  - secretRef:
      name: 'inventree-secret'
  - configMapRef:
      name: 'inventree-config'
{{- end -}}
