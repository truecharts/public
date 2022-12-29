{{/* A dict podSecContext is expected with keys like fsGroup */}}
{{- define "ix.v1.common.container.podSecurityContext" -}}
  {{- $podSecCont := .podSecCont -}}
  {{- $root := .root -}}

  {{/* Calculate all security values */}}
  {{- $security := (include "ix.v1.common.lib.podSecurityContext" (dict "root" $root "podSecCont" $podSecCont) | fromJson) }}
fsGroup: {{ $security.fsGroup }}
  {{- with $security.supplementalGroups }}
supplementalGroups:
    {{- range . }}
  - {{ . }}
    {{- end -}}
  {{- else }}
supplementalGroups: []
  {{- end -}}
  {{- with $security.fsGroupChangePolicy -}}
    {{- if not (mustHas . (list "Always" "OnRootMismatch")) -}}
      {{- fail "Invalid option for fsGroupChangePolicy. Valid options are <Always> and <OnRootMismatch>." -}}
    {{- end }}
fsGroupChangePolicy: {{ . }}
  {{- end -}}
{{- end -}}
