{{/* Define the configmap */}}
{{- define "broadcastProxy.configmap.env" -}}
{{- $fqdn := ( include "tc.v1.common.lib.chart.names.fqdn" . ) }}
enabled: true
data: {}
{{- end -}}

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
{{/* Quite a lot going on here:
   * - Resolve Jellyfin's autodiscovery service IP from its FQDN via getent hosts
   * - Export the IP to `$TARGET_IP`
   * - Check `$TARGET_IP` is not empty (so we can crash if it is - will help to detect templating errors)
   * - Touch `/tmp/healty` to use with the readiness, liveness and startup probes
   * - Start socat in proxy mode
   * - On exit remove `/tmp/healthy`
   */}}
args: ["-c", "export TARGET_IP=$(getent hosts '{{ $autodiscoverySvcFqdn }}' | awk '{ print $1 }') && [[ ! -z $TARGET_IP ]] && touch /tmp/healthy && socat UDP-LISTEN:7359,fork,reuseaddr,rcvbuf=8096 UDP4-SENDTO:${TARGET_IP}:7359,rcvbuf=8096 ; rm -rf /tmp/healthy"]
# env:
#   CFG_ID: 1
#   CFG_PORT: 7359
#   CFG_DEV: wlp61s0,wlp61s0
# command: ["/bin/sh"]
# args: ["-c", "touch /tmp/healthy && CFG_TARGET_IP=$(getent hosts jellyfin.ix-jellyfin.svc.cluster.local | awk '{ print $1 }') /entrypoint.sh ; rm -rf /tmp/healthy"]
# args: ["-c", "export CFG_TARGET_IP=$(getent hosts jellyfin.ix-jellyfin.svc.cluster.local | awk '{ print $1 }') && echo $CFG_TARGET_IP && echo 'route' && ip route get $CFG_TARGET_IP && echo 'grep' && ip -o -brief address show | grep UP"]
# args: ["-c", "ip link show; touch /tmp/healthy && CFG_TARGET_IP=$(getent hosts jellyfin.ix-jellyfin.svc.cluster.local | awk '{ print $1 }') /entrypoint.sh ; rm -rf /tmp/healthy"]
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

