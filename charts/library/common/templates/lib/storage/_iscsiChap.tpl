{{- define "tc.v1.common.lib.storage.iscsi.chap" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := dict -}}

  {{- if $objectData.iscsi.authSession -}}
    {{- with $objectData.iscsi.authSession.username -}}
      {{- $_ := set $data "node.session.auth.username" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $objectData.iscsi.authSession.password -}}
      {{- $_ := set $data "node.session.auth.password" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $objectData.iscsi.authSession.usernameInitiator -}}
      {{- $_ := set $data "node.session.auth.username_in" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $objectData.iscsi.authSession.passwordInitiator -}}
      {{- $_ := set $data "node.session.auth.password_in" (tpl . $rootCtx) -}}
    {{- end -}}
  {{- end -}}

  {{- if $objectData.iscsi.authDiscovery -}}
    {{- with $objectData.iscsi.authDiscovery.username -}}
      {{- $_ := set $data "discovery.sendtargets.auth.username" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $objectData.iscsi.authDiscovery.password -}}
      {{- $_ := set $data "discovery.sendtargets.auth.password" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $objectData.iscsi.authDiscovery.usernameInitiator -}}
      {{- $_ := set $data "discovery.sendtargets.auth.username_in" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with $objectData.iscsi.authDiscovery.passwordInitiator -}}
      {{- $_ := set $data "discovery.sendtargets.auth.password_in" (tpl . $rootCtx) -}}
    {{- end -}}
  {{- end -}}

  {{- $data | toJson -}}
{{- end -}}
