{{- define "tc.v1.common.lib.cnpg.provider.secret.spawner" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $type := .type -}}

  {{- if not $type -}}
    {{- fail "CNPG Provider Secret Spawner - No [type] was given" -}}
  {{- end -}}

  {{- $provider := "" -}}
  {{- $creds := dict -}}
  {{- if eq $type "backup" -}}
    {{- if not $objectData.backups.credentials -}}
      {{- fail "CNPG Recovery Provider Secret Spawner - Expected [backups.credentials] to be defined on [backup] mode" -}}
    {{- end -}}
    {{/* Get the creds defined in backup.$provider */}}
    {{- $creds = (get $rootCtx.Values.credentials $objectData.backups.credentials) -}}
    {{- include "tc.v1.common.lib.credentials.validation" (dict "rootCtx" $rootCtx "caller" "CNPG Backup" "credName" $objectData.backups.credentials) -}}
    {{- $provider = $creds.type -}}
  {{- else if eq $type "recovery" -}}
    {{- if not $objectData.recovery.credentials -}}
      {{- fail "CNPG Recovery Provider Secret Spawner - Expected [recovery.credentials] to be defined on [recovery] mode" -}}
    {{- end -}}
    {{/* Get the creds defined in recovery.$provider */}}
    {{- $creds = (get $rootCtx.Values.credentials $objectData.recovery.credentials) -}}
    {{- include "tc.v1.common.lib.credentials.validation" (dict "rootCtx" $rootCtx "caller" "CNPG Backup" "credName" $objectData.recovery.credentials) -}}
    {{- $provider = $creds.type -}}
  {{- end -}}

  {{- with (include (printf "tc.v1.common.lib.cnpg.provider.%s.secret" $provider) (dict "creds" $creds) | fromYaml) -}}
    {{- $_ := set $rootCtx.Values.secret (printf "cnpg-%s-provider-%s-%s-creds" $objectData.shortName $type $provider) . -}}
  {{- end -}}
{{- end -}}
