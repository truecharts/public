{{/* Returns the storageClassname */}}
{{- define "ix.v1.common.storage.storageClassName" -}}
  {{- $persistence := .persistence -}}
  {{- $root := .root -}}

  {{/*
  If a storage class is defined on a persistence object:
    "-" returns "", which means requesting a PV without class
    SCALE-ZFS returns the value set on .Values.global.ixChartContext.storageClassName
    else return the defined storageClass
  Else if there is a storageClass defined in .Values.global.ixChartContext.storageClassName, return this
  In any other case, return nothing
  */}}

  {{- if $persistence.storageClass -}}
    {{- if eq "-" $persistence.storageClass -}}
      {{- print "\"\"" -}}
    {{- else if eq "SCALE-ZFS" $persistence.storageClass -}}
      {{- if not $root.Values.global.ixChartContext.storageClassName -}}
        {{- fail "A storageClassName must be defined in global.ixChartContext.storageClassName" -}}
      {{- end -}}
      {{- print $root.Values.global.ixChartContext.storageClassName -}}
    {{- else -}}
      {{- print $persistence.storageClass -}}
    {{- end -}}
  {{- else if $root.Values.global.ixChartContext.storageClassName -}}
    {{- print $root.Values.global.ixChartContext.storageClassName -}}
  {{- end -}}
{{- end -}}
