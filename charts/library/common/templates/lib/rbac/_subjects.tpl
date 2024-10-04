{{/* Returns Subjects for rbac */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.rbac.subjects" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the RBAC.
*/}}
{{/* Parses service accounts, and checks if RBAC have selected any of them */}}
{{- define "tc.v1.common.lib.rbac.subjects" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- range $objectData.subjects }}
- kind: {{ tpl (required "RBAC - Expected non-empty [rbac.subjects.kind]" .kind) $rootCtx | quote }}
  name: {{ tpl (required "RBAC - Expected non-empty [rbac.subjects.name]" .name) $rootCtx | quote }}
  apiGroup: {{ tpl (required "RBAC - Expected non-empty [rbac.subjects.apiGroup]" .apiGroup) $rootCtx | quote }}
  {{- end -}}
{{- end -}}
