{{/* Define the configmap */}}
{{- define "owntracks.secret" -}}

enabled: true
data:
  OTR_HTTPPORT: {{ .Values.service.main.ports.main.port | quote }}
  {{- with .Values.owntracks.otr_host }}
  OTR_HOST: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_port }}
  OTR_PORT: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_user }}
  OTR_USER: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_pass }}
  OTR_PASS: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_precision }}
  OTR_PRECISION: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_geokey }}
  OTR_GEOKEY: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_borwserapikey }}
  OTR_BROWSERAPIKEY: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_serverlabel }}
  OTR_SERVERLABEL: {{ . | quote }}
  {{- end }}
  {{- with .Values.owntracks.otr_lmdbsize }}
  OTR_LMDBSIZE: {{ (int .) | quote }}
  {{- end }} {{/* Convert to int again, as it's being converted in scienfitic notation */}}
{{- end -}}
