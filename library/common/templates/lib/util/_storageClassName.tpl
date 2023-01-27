{{/* Returns the storageClassname */}}
{{- define "ix.v1.common.storage.storageClassName" -}}
  {{- $persistence := .persistence -}}
  {{- $root := .root -}}

  {{/*
    If a storage class is defined on a persistence object:
      "-" returns "", which means requesting a PV without class
      "SCALE-ZFS" returns the value set on Values.global.defaults.scaleZFSStorageClass
      else return the defined storageClass
    Else if there is a storageClass defined in Values.global.defaults.storageClass, return this
    In any other case, return nothing
  */}}

  {{- if $persistence.storageClass -}}
    {{- $className := tpl $persistence.storageClass $root -}}
    {{- if eq "-" $className -}}
      {{- print "\"\"" -}}
    {{- else if eq "SCALE-ZFS" $className -}} {{/* Later, if we have more storage classes we add another else if (eg SCALE-SMB) */}}
      {{- if not $root.Values.global.defaults.scaleZFSStorageClass -}}
        {{- fail "A storageClass must be defined in global.defaults.scaleZFSStorageClass" -}}
      {{- end -}}
      {{- print (tpl $root.Values.global.defaults.scaleZFSStorageClass $root) -}}
    {{- else -}}
      {{- print $className -}}
    {{- end -}}
  {{- else if $root.Values.ixChartContext -}}
    {{- print (tpl $root.Values.global.ixChartContext.storageClassName $root) -}}
  {{- else if $root.Values.global.defaults.storageClass -}}
    {{- print $root.Values.global.defaults.storageClass -}}
  {{- end -}}
{{- end -}}
