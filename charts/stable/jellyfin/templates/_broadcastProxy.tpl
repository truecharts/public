{{- define "broadcastProxy.container" -}}
{{- $autodiscoverySvcFqdn := printf "%v-autodiscovery" (include "tc.v1.common.lib.chart.names.fullname" $) -}}
enabled: true
primary: true
imageSelector: broadcastProxyImage
securityContext:
  runAsUser: 0
  runAsGroup: 0
  readOnlyRootFilesystem: false
command: ["/bin/sh"]
# Quite a lot going on here:
# - Resolve Jellyfin's autodiscovery service IP from its FQDN via getent hosts
# - Export the IP to `$TARGET_IP`
# - Check `$TARGET_IP` is not empty (so we can crash if it is - will help to detect templating errors)
# - Touch `/tmp/healty` to use with the readiness, liveness and startup probes
# - Start socat in proxy mode
# - On exit remove `/tmp/healthy`
args: ["-c", "export TARGET_IP=$(getent hosts '{{ $autodiscoverySvcFqdn }}' | awk '{ print $1 }') && [[ ! -z $TARGET_IP ]] && touch /tmp/healthy && socat UDP-LISTEN:7359,fork,reuseaddr,rcvbuf=8096 UDP4-SENDTO:${TARGET_IP}:7359,rcvbuf=8096 ; rm -rf /tmp/healthy"]
probes:
  readiness:
    enabled: true
    type: exec
    command:
      - cat
      - /tmp/healthy
  liveness:
    enabled: true
    type: exec
    command:
      - cat
      - /tmp/healthy
  startup:
    enabled: true
    type: exec
    command:
      - cat
      - /tmp/healthy
{{- end -}}

