{{/* Template for a ServiceAccount object, can only be called by the spawner */}}
{{/* A serviceAccount object is passed from the spawner */}}
{{- define "ix.v1.common.class.serviceAccount" -}}
  {{- $values := .serviceAccount -}}
  {{- $root := .root -}}
  {{- $saName := (include "ix.v1.common.names.fullname" $root) -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $saName = (printf "%v-%v" $saName $values.nameOverride) -}}
  {{- end }}

---
apiVersion: {{ include "ix.v1.common.capabilities.serviceAccount.apiVersion" $root }}
kind: ServiceAccount
metadata:
  name: {{ $saName }}
  {{- with (include "ix.v1.common.labels" $root | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with $values.annotations }}
  annotations:
    {{- range $k, $v := . }}
      {{- $k | nindent 4 }}: {{ tpl $v $root | quote }}
    {{- end }}
  {{- end }}
{{- end }}
