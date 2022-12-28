{{/* A dict podSecContext is expected with keys like fsGroup */}}
{{- define "ix.v1.common.container.podSecurityContext" -}}
  {{- $podSecCont := .podSecCont -}}
  {{- $root := .root -}}

  {{/* TODO: deviceList + suppleGroups */}}
  {{- $defaultPodSec := $root.Values.global.defaults.podSecurityContext -}}

  {{/* Init Values */}}
  {{- $fsGroup := $defaultPodSec.fsGroup -}}
  {{- $fsGroupChangePolicy := $defaultPodSec.fsGroupChangePolicy -}}
  {{- $supplementalGroups := $defaultPodSec.supplementalGroups -}}

  {{/* Override based on user/dev input */}}
  {{- if (hasKey $podSecCont "fsGroup") -}}
    {{- if eq (toString $podSecCont.fsGroup) "<nil>" -}}
      {{- fail (printf "<fsGroup> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $fsGroup) -}}
    {{- else if ge (int $podSecCont.fsGroup) 0 -}}
      {{- $fsGroup = $podSecCont.fsGroup -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $podSecCont "fsGroupChangePolicy") -}}
    {{- if $podSecCont.fsGroupChangePolicy -}}
      {{- $fsGroupChangePolicy = $podSecCont.fsGroupChangePolicy -}}
    {{- else -}}
      {{- fail (printf "<fsGroupChangePolicy> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $fsGroupChangePolicy) -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $podSecCont "supplementalGroups") -}}
    {{- if $podSecCont.supplementalGroups -}}
      {{- $supplementalGroups = $podSecCont.supplementalGroups -}}
    {{- else -}}
      {{- fail (printf "<supplementalGroups> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $supplementalGroups) -}}
    {{- end -}}
  {{- end }}
fsGroup: {{ $fsGroup }}
  {{- with $supplementalGroups }}
supplementalGroups:
    {{- range . }}
  - {{ . }}
    {{- end -}}
  {{- else }}
supplementalGroups: []
  {{- end -}}
  {{- with $fsGroupChangePolicy -}}
    {{- if not (mustHas . (list "Always" "OnRootMismatch")) -}}
      {{- fail "Invalid option for fsGroupChangePolicy. Valid options are <Always> and <OnRootMismatch>." -}}
    {{- end }}
fsGroupChangePolicy: {{ . }}
  {{- end -}}
{{- end -}}
