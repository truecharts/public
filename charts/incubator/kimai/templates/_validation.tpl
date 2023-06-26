{{- define "kimai.validation" -}}

  {{- if not (mustRegexMatch ".@.+\..+$" .Values.kimai.credentials.ADMINMAIL) -}}
    {{- fail (printf "Incorrect format for admin e-mail. Got [%v]" .Values.kimai.credentials.ADMINMAIL) -}}
  {{- end -}}

  {{- if not (mustRegexMatch "^$" .Values.kimai.credentials.ADMINPASS) -}}
    {{- fail (printf "Admin password must not be empty.") -}}
  {{- end -}}

{{- end -}}
