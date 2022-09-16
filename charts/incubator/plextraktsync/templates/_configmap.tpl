{{/* Define the configmap */}}
{{- define "plextraktsync.configmap" -}}

{{- $configName := printf "%s-plextraktsync-configmap" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:  {{- include "tc.common.labels" . | nindent 4 }}
data:
  .env:
    # This is .env file for PlexTraktSync
    PLEX_BASEURL={{ .Values.plexTraktSync.base_url }}
    PLEX_FALLBACKURL={{ .Values.plexTraktSync.fallback_url }}
    PLEX_LOCALURL={{ .Values.plexTraktSync.local_url }}
    PLEX_TOKEN={{ .Values.plexTraktSync.token }}
    PLEX_OWNER_TOKEN={{ .Values.plexTraktSync.owner_token }}
    PLEX_USERNAME={{ .Values.plexTraktSync.username }}
    TRAKT_USERNAME={{ .Values.plexTraktSync.trakt_username }}
{{- end -}}
