{{/* Define the configmap */}}
{{- define "collabora.configmap" -}}
{{- if lt (len .Values.collabora.password) 8 -}}
  {{- fail "Collabora - [Password] must be at least 8 characters" -}}
{{- end -}}
{{- if contains "$" .Values.collabora.password -}}
  {{- fail "Collabora - [Password] cannot contain [$]" -}}
{{- end -}}
{{- $collaboraUIModes := (list "default" "compact" "tabbed") -}}
{{- if not (mustHas .Values.collabora.interface $collaboraUIModes) -}}
  {{- fail (printf "Colabora - Expected [Interface Mode] to be one of [%v], but got [%v]" (join "," $collaboraUIModes) .Values.collabora.interface) -}}
{{- end -}}
{{- if not .Values.collabora.dictionaries -}}
  {{- fail "Collabora -  Expected non-empty [Dictionaries]" -}}
{{- end -}}

{{- $fixedParams := (list "--o:mount_jail_tree=false"
                          "--o:security.seccomp=true"
                          "--o:home_mode.enable=true"
                          "--o:logging.level=warning"
                          "--o:logging.level_startup=warning"
                  (printf "--o:user_interface.mode=%v" .Values.collabora.interface)
                  (printf "--o:ssl.enable=%v" .Values.collabora.ssl_enable)
                  (printf "--o:ssl.termination=%v" .Values.collabora.ssl_termination) ) -}}
{{- $params := concat $fixedParams .Values.collabora.extra_params -}}

{{- $checkParams := list -}}
{{- range $item := $params -}}
  {{- $checkParams = mustAppend $checkParams (regexReplaceAll "--o:(.*)=.*" $item "${1}") -}}
{{- end -}}

{{- if not (deepEqual $checkParams (uniq $checkParams)) -}}
  {{- fail (printf "Collabora - [Dictionaries] must be unique, but got [%v]" ((join ", " $params) | replace "--o:" "")) -}}
{{- end }}

collabora-config:
  enabled: true
  data:
    aliasgroup1: {{ join "," .Values.collabora.aliasgroup1 }}
    server_name: {{ .Values.collabora.server_name }}
    dictionaries: {{ join " " .Values.collabora.dictionaries }}
    username: {{ .Values.collabora.username | quote }}
    password: {{ .Values.collabora.password | quote }}
    DONT_GEN_SSL_CERT: {{ .Values.collabora.no_gen_ssl | quote }}
    extra_params: {{ join " " $params }}
{{- end -}}
