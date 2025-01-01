{{- define "tc.v1.common.class.traefik.middleware.forwardAuth" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{- if hasKey $mw "trustForwardHeader" -}}
    {{- if not (kindIs "bool" $mw.trustForwardHeader) -}}
      {{- fail (printf "Middleware (forward-auth) - Expected [trustForwardHeader] to be a boolean, but got [%s]" (kindOf $mw.trustForwardHeader)) -}}
    {{- end -}}
  {{- end -}}

  {{- if and $mw.tls (hasKey $mw.tls "insecureSkipVerify") -}}
    {{- if not (kindIs "bool" $mw.tls.insecureSkipVerify) -}}
      {{- fail (printf "Middleware (forward-auth) - Expected [tls.insecureSkipVerify] to be a boolean, but got [%s]" (kindOf $mw.tls.insecureSkipVerify)) -}}
    {{- end -}}
  {{- end -}}

  {{- if $mw.authResponseHeaders -}}
    {{- if not (kindIs "slice" $mw.authResponseHeaders) -}}
      {{- fail (printf "Middleware (forward-auth) - Expected [authResponseHeaders] to be a list, but got [%s]" (kindOf $mw.authResponseHeaders)) -}}
    {{- end -}}
  {{- end -}}

  {{- with $mw.authRequestHeaders -}}
    {{- if not (kindIs "slice" $mw.authRequestHeaders) -}}
      {{- fail (printf "Middleware (forward-auth) - Expected [authRequestHeaders] to be a list, but got [%s]" (kindOf $mw.authRequestHeaders)) -}}
    {{- end -}}
  {{- end -}}

  {{- if not $mw.address -}}
    {{- fail "Middleware (forward-auth) - Expected [address] to be set" -}}
  {{- end }}
  forwardAuth:
    address: {{ $mw.address }}
    trustForwardHeader: {{ $mw.trustForwardHeader }}

    {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "authResponseHeadersRegex" "value" $mw.authResponseHeadersRegex) | nindent 4 }}

    {{- if $mw.authResponseHeaders }}
    authResponseHeaders:
      {{- range $mw.authResponseHeaders }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.authRequestHeaders }}
    authRequestHeaders:
      {{- range $mw.authRequestHeaders }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.tls }}
    tls:
      insecureSkipVerify: {{ $mw.tls.insecureSkipVerify }}
    {{- end -}}
{{- end -}}
