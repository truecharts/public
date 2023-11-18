{{/* Returns iscsi Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.iscsi" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.iscsi" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.iscsi -}}
    {{- fail "Persistence - Expected non-empty [iscsi] object on [iscsi] type" -}}
  {{- end -}}

  {{- with $objectData.iscsi.fsType -}}
    {{- $validFSTypes := (list "ext4" "xfs" "ntfs") -}}
    {{- $fsType := tpl . $rootCtx -}}
    {{- if not (mustHas $fsType $validFSTypes) -}}
      {{- fail (printf "Persistence - Expected [fsType] on [iscsi] type to be one of [%s], but got [%s]" (join ", " $validFSTypes) $fsType) -}}
    {{- end -}}
  {{- end -}}

  {{- if not $objectData.iscsi.targetPortal -}}
    {{- fail "Persistence - Expected non-empty [targetPortal] on [iscsi] type" -}}
  {{- end -}}

  {{- if not $objectData.iscsi.iqn -}}
    {{- fail "Persistence - Expected non-empty [iqn] on [iscsi] type" -}}
  {{- end -}}

  {{- if (kindIs "invalid" $objectData.iscsi.lun) -}}
    {{- fail "Persistence - Expected non-empty [lun] on [iscsi] type" -}}
  {{- end -}}
  {{- $lun := $objectData.iscsi.lun -}}
  {{- if (kindIs "string" $lun) -}}
    {{- $lun = tpl $lun $rootCtx | float64 -}}
  {{- end -}}

  {{- $authSession := false -}}
  {{- $authDiscovery := false -}}
  {{- if $objectData.iscsi.authSession -}}
    {{- $authSession = true -}}
  {{- end -}}
  {{- if $objectData.iscsi.authDiscovery -}}
    {{- $authDiscovery = true -}}
  {{- end }}

- name: {{ $objectData.shortName }}
  iscsi:
    targetPortal: {{ tpl $objectData.iscsi.targetPortal $rootCtx }}
    {{- with $objectData.iscsi.portals }}
    portals:
      {{- range $portal := . }}
      - {{ tpl $portal $rootCtx | quote }}
      {{- end -}}
    {{- end }}
    iqn: {{ tpl $objectData.iscsi.iqn $rootCtx }}
    lun: {{ include "tc.v1.common.helper.makeIntOrNoop" $lun }}
    {{- with $objectData.iscsi.iscsiInterface }}
    iscsiInterface: {{ tpl . $rootCtx }}
    {{- end -}}
    {{- with $objectData.iscsi.initiatorName }}
    initiatorName: {{ tpl .  $rootCtx }}
    {{- end -}}
    {{- with $objectData.iscsi.fsType }}
    fsType: {{ tpl . $rootCtx }}
    {{- end }}
    chapAuthSession: {{ $authSession }}
    chapAuthDiscovery: {{ $authDiscovery }}
    {{- if or $authSession $authDiscovery -}}
      {{- $secretName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $objectData.shortName) }}
    secretRef:
        name: {{ $secretName }}
    {{- end -}}
{{- end -}}
