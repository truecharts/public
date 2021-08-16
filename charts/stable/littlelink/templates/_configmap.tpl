{{/* Define the configmap */}}
{{- define "littlelink.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: littlelinkconfig
data:
  {{- if .Values.littlelink.tiktok }}
  TIKTOK: {{ .Values.littlelink.tiktok | quote }}
  {{- end }}
  {{- if .Values.littlelink.kit }}
  KIT: {{ .Values.littlelink.kit | quote }}
  {{- end }}
  {{- if .Values.littlelink.facebook }}
  FACEBOOK: {{ .Values.littlelink.facebook | quote }}
  {{- end }}
  {{- if .Values.littlelink.facebook_messenger }}
  FACEBOOK_MESSENGER: {{ .Values.littlelink.facebook_messenger | quote }}
  {{- end }}
  {{- if .Values.littlelink.linked_in }}
  LINKED_IN: {{ .Values.littlelink.linked_in | quote }}
  {{- end }}
  {{- if .Values.littlelink.product_hunt }}
  PRODUCT_HUNT: {{ .Values.littlelink.product_hunt | quote }}
  {{- end }}
  {{- if .Values.littlelink.snapchat }}
  SNAPCHAT: {{ .Values.littlelink.snapchat | quote }}
  {{- end }}
  {{- if .Values.littlelink.spotify }}
  SPOTIFY: {{ .Values.littlelink.spotify | quote }}
  {{- end }}
  {{- if .Values.littlelink.reddit }}
  REDDIT: {{ .Values.littlelink.reddit | quote }}
  {{- end }}
  {{- if .Values.littlelink.medium }}
  MEDIUM: {{ .Values.littlelink.medium | quote }}
  {{- end }}
  {{- if .Values.littlelink.pinterest }}
  PINTEREST: {{ .Values.littlelink.pinterest | quote }}
  {{- end }}
  {{- if .Values.littlelink.email }}
  EMAIL: {{ .Values.littlelink.email | quote }}
  {{- end }}
  {{- if .Values.littlelink.email_alt }}
  EMAIL_ALT: {{ .Values.littlelink.email_alt | quote }}
  {{- end }}
  {{- if .Values.littlelink.sound_cloud }}
  SOUND_CLOUD: {{ .Values.littlelink.sound_cloud | quote }}
  {{- end }}
  {{- if .Values.littlelink.figma }}
  FIGMA: {{ .Values.littlelink.figma | quote }}
  {{- end }}
  {{- if .Values.littlelink.telegram }}
  TELEGRAM: {{ .Values.littlelink.telegram | quote }}
  {{- end }}
  {{- if .Values.littlelink.tumblr }}
  TUMBLR: {{ .Values.littlelink.tumblr | quote }}
  {{- end }}
  {{- if .Values.littlelink.steam }}
  STEAM: {{ .Values.littlelink.steam | quote }}
  {{- end }}
  {{- if .Values.littlelink.vimeo }}
  VIMEO: {{ .Values.littlelink.vimeo | quote }}
  {{- end }}
  {{- if .Values.littlelink.wordpress }}
  WORDPRESS: {{ .Values.littlelink.wordpress | quote }}
  {{- end }}
  {{- if .Values.littlelink.goodreads }}
  GOODREADS: {{ .Values.littlelink.goodreads | quote }}
  {{- end }}
  {{- if .Values.littlelink.skoob }}
  SKOOB: {{ .Values.littlelink.skoob | quote }}
  {{- end }}
  {{- if .Values.littlelink.footer }}
  FOOTER: {{ .Values.littlelink.footer | quote }}
  {{- end }}

{{- end -}}
