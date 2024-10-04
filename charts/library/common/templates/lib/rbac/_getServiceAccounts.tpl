{{/* Returns Service Account List for rbac */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.rbac.serviceAccount" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the RBAC.
*/}}
{{/* Parses service accounts, and checks if RBAC have selected any of them */}}
{{- define "tc.v1.common.lib.rbac.serviceAccount" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $serviceAccounts := list -}}

  {{- range $name, $serviceAccount := $rootCtx.Values.serviceAccount -}}
    {{- $saName := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}

    {{- if $serviceAccount.enabled -}}

      {{- if not $serviceAccount.primary -}}
        {{- $saName = (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $name) -}}
      {{- end -}}

      {{/* If allServiceAccounts is true */}}
      {{- if $objectData.allServiceAccounts -}}
        {{- $serviceAccounts = mustAppend $serviceAccounts $saName -}}

      {{/* Else if serviceAccounts is a list */}}
      {{- else if (kindIs "slice" $objectData.serviceAccounts) -}}
        {{- if (mustHas $name $objectData.serviceAccounts) -}}
          {{- $serviceAccounts = mustAppend $serviceAccounts $saName -}}
        {{- end -}}

      {{/* If not "allServiceAccounts" or "serviceAccounts", assign the primary service account to rbac */}}
      {{- else if $serviceAccount.primary -}}
        {{- if $objectData.primary -}}
          {{- $serviceAccounts = mustAppend $serviceAccounts $saName -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{- if not $serviceAccounts -}}
    {{- fail "RBAC - Expected at least one serviceAccount to be assigned. Assign one using [allServiceAccounts (boolean), serviceAccounts (list)]" -}}
  {{- end -}}

  {{- range $serviceAccounts }}
- kind: ServiceAccount
  name: {{ . }}
  namespace: {{ $rootCtx.Release.Namespace }}
  {{- end -}}
{{- end -}}
