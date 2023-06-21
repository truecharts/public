{{- define "nextcloud.validation" -}}

  {{- if not (mustRegexMatch "^[0-9]+(M|G){1}$" .Values.nextcloud.php.memory_limit) -}}
    {{- fail (printf "Nextcloud - Expected Memory Limit to be in format [1M, 1G] but got [%v]" .Values.nextcloud.php.memory_limit) -}}
  {{- end -}}

  {{- if not (mustRegexMatch "^[0-9]+(M|G){1}$" .Values.nextcloud.php.upload_limit) -}}
    {{- fail (printf "Nextcloud - Expected Memory Limit to be in format [1M, 1G] but got [%v]" .Values.nextcloud.php.upload_limit) -}}
  {{- end -}}

  {{- if not (deepEqual .Values.nextcloud.previews.providers (uniq .Values.nextcloud.previews.providers)) -}}
    {{- fail (printf "Nextcloud - Expected preview providers to be unique but got [%v]" .Values.nextcloud.previews.providers) -}}
  {{- end -}}

  {{- if and .Values.nextcloud.collabora.enabled .Values.nextcloud.onlyoffice.enabled -}}
    {{- fail "Nextcloud - Expected only one of [Collabora, OnlyOffice] to be enabled" -}}
  {{- end -}}

  {{- if contains "$" .Values.nextcloud.collabora.password -}}
    {{- fail "Nextcloud - Collabora [Password] cannot contain [$]" -}}
  {{- end -}}

  {{- if .Values.nextcloud.collabora.enabled -}}
    {{- if lt (len .Values.nextcloud.collabora.password) 8 -}}
      {{- fail "Nextcloud - Collabora [Password] must be at least 8 characters" -}}
    {{- end -}}

    {{- $collaboraUIModes := (list "default" "compact" "tabbed") -}}
    {{- if not (mustHas .Values.nextcloud.collabora.interface_mode $collaboraUIModes) -}}
      {{- fail (printf "Nextcloud - Expected [Interface Mode] in Collabora to be one of [%v], but got [%v]" (join "," $collaboraUIModes) .Values.nextcloud.collabora.interface_mode) -}}
    {{- end -}}

    {{- if not .Values.nextcloud.collabora.dictionaries -}}
      {{- fail "Nextcloud - Expected non-empty Collabora [Dictionaries]" -}}
    {{- end -}}

    {{- if not (deepEqual .Values.nextcloud.collabora.dictionaries (uniq .Values.nextcloud.collabora.dictionaries)) -}}
      {{- fail "Nextcloud - Collabora [Dictionaries] must be unique" -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
