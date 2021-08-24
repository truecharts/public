{{/* Define the configmap */}}
{{- define "littlelink.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: littlelinkconfig
data:
  {{- if .Values.littlelink.meta_title }}
  META_TILE: {{ .Values.littlelink.meta_title | quote }}
  {{- end }}
  {{- if .Values.littlelink.meta_description }}
  META_DESCRIPTION: {{ .Values.littlelink.meta_description | quote }}
  {{- end }}
  {{- if .Values.littlelink.meta_author }}
  META_AUTHOR: {{ .Values.littlelink.meta_author | quote }}
  {{- end }}
  {{- if .Values.littlelink.theme }}
  THEME: {{ .Values.littlelink.theme | quote }}
  {{- end }}
  {{- if .Values.littlelink.favicon_url }}
  FAVICON_URL: {{ .Values.littlelink.favicon_url | quote }}
  {{- end }}
  {{- if .Values.littlelink.avatar_url }}
  AVATAR_URL: {{ .Values.littlelink.avatar_url | quote }}
  {{- end }}
  {{- if .Values.littlelink.avatar_2x_url }}
  AVATAR_2X_URL: {{ .Values.littlelink.avatar_2x_url | quote }}
  {{- end }}
  {{- if .Values.littlelink.avatar_alt }}
  AVATAR_ALT: {{ .Values.littlelink.avatar_alt | quote }}
  {{- end }}
  {{- if .Values.littlelink.name }}
  NAME: {{ .Values.littlelink.name | quote }}
  {{- end }}
  {{- if .Values.littlelink.bio }}
  BIO: {{ .Values.littlelink.bio | quote }}
  {{- end }}
  {{- if .Values.littlelink.github }}
  GITHUB: {{ .Values.littlelink.github | quote }}
  {{- end }}
  {{- if .Values.littlelink.twitter }}
  TWITTER: {{ .Values.littlelink.twitter | quote }}
  {{- end }}
  {{- if .Values.littlelink.instagram }}
  INSTAGRAM: {{ .Values.littlelink.instagram | quote }}
  {{- end }}
  {{- if .Values.littlelink.youtube }}
  YOUTUBE: {{ .Values.littlelink.youtube | quote }}
  {{- end }}
  {{- if .Values.littlelink.twitch }}
  TWITCH: {{ .Values.littlelink.twitch | quote }}
  {{- end }}
  {{- if .Values.littlelink.discord }}
  DISCORD: {{ .Values.littlelink.discord | quote }}
  {{- end }}
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
