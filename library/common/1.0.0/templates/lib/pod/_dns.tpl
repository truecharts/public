{{/* Returns dnsPolicy */}}
{{- define "ix.v1.common.dnsPolicy" -}}
  {{- $policy := "ClusterFirst" -}}
  {{- if .Values.dnsPolicy -}}
    {{- if not (mustHas .Values.dnsPolicy (list "Default" "ClusterFirst" "ClusterFirstWithHostNet" "None"))  -}}
      {{- fail "Not valid dnsPolicy. Valid options are ClusterFirst, Default, ClusterFirstWithHostNet, None" -}}
    {{- end -}}
    {{- $policy = .Values.dnsPolicy -}}
  {{- else if .Values.hostNetwork -}}
    {{- $policy = "ClusterFirstWithHostNet" -}}
  {{- end -}}
{{- $policy -}}
{{- end -}}

{{/* Returns dnsConfig */}}
{{- define "ix.v1.common.dnsConfig" -}}
  {{- if and (eq .Values.dnsPolicy "None") (not .Values.dnsConfig.nameservers) -}}
    {{- fail "With dnsPolicy set to None, you must specify at least 1 nameservers on dnsConfig" -}}
  {{- end -}}
  {{- if or .Values.dnsConfig.nameservers .Values.dnsConfig.searches .Values.dnsConfig.options -}}
    {{- with .Values.dnsConfig.nameservers -}}
      {{- if gt (len .) 3 -}}
        {{- fail "There can be at most 3 nameservers specified in dnsConfig" -}}
      {{- end -}}
nameservers:
      {{- range . }}
  - {{ tpl . $ }}
      {{- end }}
    {{- end -}}
    {{- with .Values.dnsConfig.searches -}}
      {{- if gt (len .) 6 -}}
        {{- fail "There can be at most 6 search domains specified in dnsConfig" -}}
      {{- end }}
searches:
      {{- range . }}
  - {{  tpl . $ }}
      {{- end }}
    {{- end -}}
    {{- with .Values.dnsConfig.options }}
options:
      {{- range . }}
  - name: {{ tpl .name $ }}
        {{- with .value }}
    value: {{ tpl (toString .)  $ | quote }}
        {{- end }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
