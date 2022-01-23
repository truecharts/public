{{/* Define the configmap */}}
{{- define "deepstack.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: deepstack-env
data:
  # VISION-FACE
  {{- if eq .Values.deepstack.vision_face true }}
  VISION-FACE: "True"
  {{- else }}
  VISION-FACE: "False"
  {{- end }}
  # VISION-DETECTION
  {{- if eq .Values.deepstack.vision_detection true }}
  VISION-DETECTION: "True"
  {{- else }}
  VISION-DETECTION: "False"
  {{- end }}
  # VISION-SCENE
  {{- if eq .Values.deepstack.vision_scene true }}
  VISION-SCENE: "True"
  {{- else }}
  VISION-SCENE: "False"
  {{- end }}
  # VISION-ENHANCE
  {{- if eq .Values.deepstack.vision_enhance true }}
  VISION-ENHANCE: "True"
  {{- else }}
  VISION-ENHANCE: "False"
  {{- end }}
{{- end -}}
