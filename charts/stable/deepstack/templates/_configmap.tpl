{{/* Define the configmap */}}
{{- define "deepstack.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: deepstack-env
data:
  # VISION-FACE
  {{- if eq .Values.app.vision_face true }}
  VISION-FACE: "True"
  {{- else }}
  VISION-FACE: "False"
  {{- end }}
  # VISION-DETECTION
  {{- if eq .Values.app.vision_detection true }}
  VISION-DETECTION: "True"
  {{- else }}
  VISION-DETECTION: "False"
  {{- end }}
  # VISION-SCENE
  {{- if eq .Values.app.vision_scene true }}
  VISION-SCENE: "True"
  {{- else }}
  VISION-SCENE: "False"
  {{- end }}
  # VISION-ENHANCE
  {{- if eq .Values.app.vision_enhance true }}
  VISION-ENHANCE: "True"
  {{- else }}
  VISION-ENHANCE: "False"
  {{- end }}
{{- end -}}
