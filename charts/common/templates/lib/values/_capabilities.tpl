{{/* automatically set CAP_NET_BIND_SERVICE */}}
{{- define "tc.common.lib.values.capabilities" -}}
  {{- $fixedCapAdd := list }}
  {{- $customCapAdd := list }}
  {{- $valueCapAdd := list }}
  {{- $dynamicCapAdd := list }}
  {{- $fixedCapDrop := list }}
  {{- $customCapDrop := list }}
  {{- $valueCapDrop := list }}
  {{- $dynamicCapDrop := list }}
  {{- if .Values.securityContext.capabilities.add }}
  {{- $valueCapAdd = .Values.securityContext.capabilities.add }}
  {{- end }}
  {{- if .Values.securityContext.capabilities.drop }}
  {{- $valueCapDrop = .Values.securityContext.capabilities.drop }}
  {{- end }}
  {{- if .Values.customCapabilities.add }}
  {{- $customCapAdd = .Values.customCapabilities.add }}
  {{- end }}
  {{- if .Values.customCapabilities.drop }}
  {{- $customCapDrop = .Values.customCapabilities.drop }}
  {{- end }}

  {{- $privPort := false }}
  {{- range .Values.service }}
  {{- range $name, $values := .ports }}
  {{- if and ( $values.targetPort ) ( kindIs "int" $values.targetPort ) }}
  {{- if ( semverCompare "<= 1024" ( toString $values.targetPort ) ) }}
  {{- $privPort = true }}
  {{- end }}
  {{- else if and ( $values.port ) ( kindIs "int" $values.port )  }}
  {{- if ( semverCompare "<= 1024" ( toString $values.port ) ) }}
  {{- $privPort = true }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}

  {{- if $privPort }}
  {{- $dynamicCapAdd = list "NET_BIND_SERVICE" }}
  {{- end }}

  {{/* combine and write all capabilities to .Values */}}
  {{- $CapAdd := concat $fixedCapAdd $valueCapAdd $dynamicCapAdd }}
  {{- $CapDrop := concat $fixedCapDrop $valueCapDrop $dynamicCapDrop }}
  {{- if $CapDrop }}
  {{- $_ := set .Values.securityContext.capabilities "drop" $CapDrop -}}
  {{- end }}
  {{- if $CapAdd }}
  {{- $_ := set .Values.securityContext.capabilities "add" $CapAdd -}}
  {{- end }}
{{- end -}}
