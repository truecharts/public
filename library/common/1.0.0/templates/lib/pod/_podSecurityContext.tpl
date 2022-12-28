{{/* A dict podSecContext is expected with keys like runAsUser */}}
{{- define "ix.v1.common.container.podSecurityContext" -}}
  {{- $podSecCont := .podSecCont -}}
runAsUser: {{ required "<runAsUser> value is required." $podSecCont.runAsUser }}
runAsGroup: {{ required "<runAsGroup> value is required." $podSecCont.runAsGroup }}
fsGroup: {{ required "<fsGroup> value is required." $podSecCont.fsGroup }}
  {{- with $podSecCont.supplementalGroups }} {{/* TODO: deviceList + suppleGroups */}}
supplementalGroups:
    {{- range . }}
  - {{ . }}
    {{- end -}}
  {{- end -}}
  {{- with $podSecCont.fsGroupChangePolicy -}}
    {{- if not (mustHas . (list "Always" "OnRootMismatch")) -}}
      {{- fail "Invalid option for fsGroupChangePolicy. Valid options are <Always> and <OnRootMismatch>." -}}
    {{- end }}
fsGroupChangePolicy: {{ . }}
  {{- end -}}
{{- end -}}
