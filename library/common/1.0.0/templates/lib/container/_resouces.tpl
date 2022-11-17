{{/* Returns the resources for the container */}}
{{- define "ix.v1.common.container.resources" -}}
  {{- $resources := .resources -}}
  {{- $gpu := .SCALE -}}

  {{- with $resources -}}
    {{- with .limits }}
      {{- if or .cpu .memory $gpu.gpu -}} {{/* Only add "limits" if at least one is defined */}}
        {{- print "limits:" | nindent 0 }}
        {{- with .cpu }}
          {{- printf "cpu: %s" . | nindent 2 }}
        {{- end -}}
        {{- with .memory }}
          {{- printf "memory: %s" . | nindent 2 }}
        {{- end -}}
        {{- with $gpu -}}
          {{- with .gpu }}
            {{- printf "gpu: %v" . | nindent 2 -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- with .requests }}
      {{- if or .cpu .memory -}} {{/* Only add "requests" if at least one is defined */}}
        {{- print "requests:" | nindent 0 }}
        {{- with .cpu }}
          {{- printf "cpu: %s" . | nindent 2 }}
        {{- end -}}
        {{- with .memory }}
          {{- printf "memory: %s" . | nindent 2 }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
