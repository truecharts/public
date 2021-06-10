{{/*
Renders the Persistent Volume Claim objects required by the chart.
*/}}
{{- define "common.pvc" -}}
  {{- $perDict := dict }}
  {{- range $index, $item := .Values.persistenceList -}}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $perDict $name $item }}
  {{- end }}
  {{- $per := merge .Values.persistence $perDict }}
  {{- $_ := set .Values "persistence" (deepCopy $per) -}}

  {{- /* Generate pvc as required */ -}}
  {{- range $index, $PVC := .Values.persistence }}
    {{- if and $PVC.enabled (eq (default "pvc" $PVC.type) "pvc") (not $PVC.existingClaim) -}}
      {{- $persistenceValues := $PVC -}}
      {{- if not $persistenceValues.nameOverride -}}
        {{- $_ := set $persistenceValues "nameOverride" $index -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "persistence" $persistenceValues) -}}
      {{- include "common.classes.pvc" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
