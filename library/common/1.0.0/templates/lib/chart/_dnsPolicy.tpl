{{/* Returns dnsPolicy */}}
{{- define "ix.v1.common.dnsPolicy" -}}
  {{- $policy := "ClusterFirst" -}}
  {{- if .Values.dnsPolicy -}}
    {{- if and (ne .Values.dnsPolicy "Default") (ne .Values.dnsPolicy "ClusterFirst") (ne .Values.dnsPolicy "ClusterFirstWithHostNet") (ne .Values.dnsPolicy "None")  -}}
      {{- fail "Not valid dnsPolicy. Valid options are ClusterFirst, Default, ClusterFirstWithHostNet, None" -}}
    {{- end -}}
    {{- $policy = .Values.dnsPolicy -}}
  {{- else if .Values.hostNetwork -}}
    {{- $policy = "ClusterFirstWithHostNet" -}}
  {{- end -}}
{{- $policy -}}
{{- end -}}
