{{- define "tc.v1.common.lib.volsync.moversecuritycontext" -}}
  {{- $creds := .creds -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData -}}
  {{- $target := get $volsyncData .target -}}

  {{- $sec := dict
      "runAsUser" $rootCtx.Values.securityContext.container.runAsUser
      "runAsGroup" $rootCtx.Values.securityContext.container.runAsGroup
      "fsGroup" $rootCtx.Values.securityContext.pod.fsGroup
  -}}

  {{- if $target.moverSecurityContext -}}
    {{- $items := list "runAsUser" "runAsGroup" "fsGroup" -}}
    {{- range $item := $items -}}
      {{- if hasKey $target.moverSecurityContext $item -}}
        {{- $_ := set $sec $item (get $target.moverSecurityContext $item) -}}
      {{- end -}}
    {{- end -}}
  {{- end }}

moverSecurityContext:
  runAsUser: {{ $sec.runAsUser }}
  runAsGroup: {{ $sec.runAsGroup }}
  fsGroup: {{ $sec.fsGroup }}
{{- end -}}
