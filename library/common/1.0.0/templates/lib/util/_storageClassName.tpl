{{/* Returns the storageClassname */}}
{{- define "ix.v1.common.storage.storageClassName" -}}
  {{- $persistence := .persistence -}}
  {{- $root := .root -}}

  {{/*
  If a storage class is defined on a persistence object:
    "-" returns "", which means requesting a PV without class
    SCALE-ZFS returns the value set on Values.global.defaults.storageClassName
    else return the defined storageClass
  Else if there is a storageClass defined in Values.global.defaults.storageClassName, return this
  In any other case, return nothing
  */}}

  {{- if $persistence.storageClass -}}
    {{- $className := tpl $persistence.storageClass $root -}}
    {{- if eq "-" $className -}}
      {{- print "\"\"" -}}
    {{- else if eq "SCALE-ZFS" $className -}}
      {{- if not $root.Values.global.defaults.storageClassName -}}
        {{- fail "A storageClassName must be defined in global.defaults.storageClassName" -}}
      {{- end -}}
      {{- print $root.Values.global.defaults.storageClassName -}}
    {{- else -}}
      {{- print $className -}}
    {{- end -}}
  {{- else if $root.Values.global.defaults.storageClassName -}}
    {{- print $root.Values.global.defaults.storageClassName -}}
  {{- end -}}
{{- end -}}
