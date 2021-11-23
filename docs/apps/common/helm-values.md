# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our Common Chart.
This chart is used by a lot of our Apps to provide sane defaults and logic.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers | object | `{}` | Specify any additional containers here as dictionary items. Each additional container should have its own key. Helm templates can be used. |
| addons | object | See below | The common chart supports several add-ons. These can be configured under this key. |
| addons.codeserver | object | See values.yaml | The common library supports adding a code-server add-on to access files. It can be configured under this key. For more info, check out [our docs](http://docs.k8s-at-home.com/our-helm-charts/common-library-add-ons/#code-server) |
| addons.codeserver.enabled | bool | `false` | Enable running a code-server container in the pod |
| addons.codeserver.env | object | `{}` | Set any environment variables for code-server here |
| addons.codeserver.envList | list | `[]` | All variables specified here will be added to the codeserver sidecar container See the documentation of the codeserver image for all config values |
| addons.codeserver.git | object | See below | Optionally allow access a Git repository by passing in a private SSH key |
| addons.codeserver.git.deployKey | string | `""` | Raw SSH private key |
| addons.codeserver.git.deployKeyBase64 | string | `""` | Base64-encoded SSH private key. When both variables are set, the raw SSH key takes precedence. |
| addons.codeserver.git.deployKeySecret | string | `""` | Existing secret containing SSH private key The chart expects it to be present under the `id_rsa` key. |
| addons.codeserver.ingress.enabled | bool | `false` | Enable an ingress for the code-server add-on. |
| addons.codeserver.service.enabled | bool | `true` | Enable a service for the code-server add-on. |
| addons.codeserver.workingDir | string | `"/"` | Specify the working dir that will be opened when code-server starts If not given, the app will default to the mountpah of the first specified volumeMount |
| addons.netshoot | object | See values.yaml | The common library supports adding a netshoot add-on to troubleshoot network issues within a Pod. It can be configured under this key. |
| addons.netshoot.enabled | bool | `false` | Enable running a netshoot container in the pod |
| addons.netshoot.env | object | `{}` | Set any environment variables for netshoot here |
| addons.netshoot.envList | list | `[]` | All variables specified here will be added to the netshoot sidecar container See the documentation of the netshoot image for all config values |
| addons.promtail | object | See values.yaml | The common library supports adding a promtail add-on to to access logs and ship them to loki. It can be configured under this key. |
| addons.promtail.enabled | bool | `false` | Enable running a promtail container in the pod |
| addons.promtail.env | object | `{}` | Set any environment variables for promtail here |
| addons.promtail.envList | list | `[]` | All variables specified here will be added to the promtail sidecar container See the documentation of the promtail image for all config values |
| addons.promtail.logs | list | `[]` | The paths to logs on the volume |
| addons.promtail.loki | string | `""` | The URL to Loki |
| addons.vpn | object | See values.yaml | The common chart supports adding a VPN add-on. It can be configured under this key. For more info, check out [our docs](http://docs.k8s-at-home.com/our-helm-charts/common-library-add-ons/#wireguard-vpn) |
| addons.vpn.configFile | object | `{"enabled":true,"hostPath":"/vpn/vpn.conf","hostPathType":"File","noMount":true,"type":"hostPath"}` | Provide a customized vpn configuration file to be used by the VPN. |
| addons.vpn.configFile.hostPath | string | `"/vpn/vpn.conf"` | Which path on the host should be mounted. |
| addons.vpn.configFile.hostPathType | string | `"File"` | Specifying a hostPathType adds a check before trying to mount the path. See Kubernetes documentation for options. |
| addons.vpn.env | object | `{}` | All variables specified here will be added to the vpn sidecar container See the documentation of the VPN image for all config values |
| addons.vpn.envList | list | `[]` | All variables specified here will be added to the vpn sidecar container See the documentation of the VPN image for all config values |
| addons.vpn.openvpn | object | See below | OpenVPN specific configuration |
| addons.vpn.openvpn.username | string | `""` | Credentials to connect to the VPN Service (used with -a) Only using password is enough |
| addons.vpn.securityContext | object | See values.yaml | Set the VPN container specific securityContext |
| addons.vpn.type | string | `"disabled"` | Specify the VPN type. Valid options are disabled, openvpn or wireguard |
| affinity | object | `{}` | Defines affinity constraint rules. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| alpineImage | object | See below | alpine specific configuration |
| alpineImage.pullPolicy | string | `"IfNotPresent"` | Specify the Alpine image pull policy |
| alpineImage.repository | string | `"ghcr.io/truecharts/alpine"` | Specify the Alpine image |
| alpineImage.tag | string | `"v3.14.2@sha256:a537d87e3d22c5b3f695218ca1fb5a031fb0ccafa0e3e256ef45188ab0575be6"` | Specify the Alpine image tag |
| args | list | `[]` | Override the args for the default container |
| autoscaling | object | <disabled> | Add a Horizontal Pod Autoscaler |
| codeserverImage | object | See below | codeserver specific configuration |
| codeserverImage.pullPolicy | string | `"IfNotPresent"` | Specify the code-server image pull policy |
| codeserverImage.repository | string | `"ghcr.io/truecharts/code-server"` | Specify the code-server image |
| codeserverImage.tag | string | `"v3.12.0@sha256:2853a8bdd8eed9c09bcd4b100b9d4be20c42a307b9d1cbae1a204276e948f9ce"` | Specify the code-server image tag |
| command | list | `[]` | Override the command(s) for the default container |
| configmap | object | See below | Configure configMaps for the chart here. Additional configMaps can be added by adding a dictionary key similar to the 'config' object. |
| configmap.config.annotations | object | `{}` | Annotations to add to the configMap |
| configmap.config.data | object | `{}` | configMap data content. Helm template enabled. |
| configmap.config.enabled | bool | `false` | Enables or disables the configMap |
| configmap.config.labels | object | `{}` | Labels to add to the configMap |
| controller.annotations | object | `{}` |  |
| controller.annotationsList | list | `[]` | Set additional annotations on the deployment/statefulset/daemonset |
| controller.enabled | bool | `true` | enable the controller. |
| controller.labels | object | `{}` |  |
| controller.labelsList | list | `[]` | Set additional labels on the deployment/statefulset/daemonset |
| controller.replicas | int | `1` | Number of desired pods |
| controller.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| controller.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| controller.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| controller.rollingUpdate.unavailable | string | `nil` | Set deployment RollingUpdate max unavailable |
| controller.strategy | string | `nil` | Set the controller upgrade strategy For Deployments, valid values are Recreate (default) and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate (default). DaemonSets ignore this. |
| controller.type | string | `"deployment"` | Set the controller type. Valid options are deployment, daemonset or statefulset |
| customCapabilities | object | `{"add":[],"drop":[]}` | Can be used to set securityContext.capabilities outside of the GUI on TrueNAS SCALE |
| deviceList | list | [] | Configure persistenceList for the chart here. Used to create an additional GUI element in SCALE for mounting USB devices Additional items can be added by adding a items similar to persistence |
| dnsConfig | object | `{"nameservers":[],"options":[{"name":"ndots","value":"1"}],"searches":[]}` | Optional DNS settings, configuring the ndots option may resolve nslookup issues on some Kubernetes setups. |
| dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| enableServiceLinks | bool | `false` | Enable/disable the generation of environment variables for services. [[ref]](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service) |
| env | object | `{}` | Main environment variables. Template enabled. Syntax options: A) TZ: UTC B) PASSWD: '{{ .Release.Name }}' C) PASSWD:      envFrom:        ... |
| envFrom | list | `[]` |  |
| envTpl | object | `{}` |  |
| envValueFrom | object | `{}` |  |
| global.fullnameOverride | string | `nil` | Set the entire name definition |
| global.isSCALE | bool | `false` |  |
| global.nameOverride | string | `nil` | Set an override for the prefix of the fullname |
| hostAliases | list | `[]` | Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames. [[ref]](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| hostNetwork | bool | `false` | When using hostNetwork make sure you set dnsPolicy to `ClusterFirstWithHostNet` |
| hostname | string | `nil` | Allows specifying explicit hostname setting |
| image.pullPolicy | string | `nil` | image pull policy |
| image.repository | string | `nil` | image repository |
| image.tag | string | `nil` | image tag |
| ingress | object | See below | Configure the ingresses for the chart here. Additional ingresses can be added by adding a dictionary key similar to the 'main' ingress. |
| ingress.main.enableFixedMiddlewares | bool | `true` | disable to ignore any default middlwares |
| ingress.main.enabled | bool | `false` | Enables or disables the ingress |
| ingress.main.fixedMiddlewares | list | `["chain-basic"]` | List of middlewares in the traefikmiddlewares k8s namespace to add automatically Creates an annotation with the middlewares and appends k8s and traefik namespaces to the middleware names Primarily used for TrueNAS SCALE to add additional (seperate) middlewares without exposing them to the end-user |
| ingress.main.hosts[0].host | string | `"chart-example.local"` | Host address. Helm template can be passed. |
| ingress.main.hosts[0].paths[0].path | string | `"/"` | Path.  Helm template can be passed. |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` | Ignored if not kubeVersion >= 1.14-0 |
| ingress.main.hosts[0].paths[0].service.name | string | `nil` | Overrides the service name reference for this path |
| ingress.main.hosts[0].paths[0].service.port | string | `nil` | Overrides the service port reference for this path |
| ingress.main.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. Requires Kubernetes >=1.19 |
| ingress.main.middlewares | list | `[]` | Additional List of middlewares in the traefikmiddlewares k8s namespace to add automatically Creates an annotation with the middlewares and appends k8s and traefik namespaces to the middleware names |
| ingress.main.nameOverride | string | `nil` | Override the name suffix that is used for this ingress. |
| ingress.main.primary | bool | `true` | Make this the primary ingress (used in probes, notes, etc...). If there is more than 1 ingress, make sure that only 1 ingress is marked as primary. |
| ingress.main.tls | list | `[]` | Configure TLS for the ingress. Both secretName and hosts can process a Helm template. |
| ingressList | list | [] | Configure ingressList for the chart here. Additional items can be added by adding a items similar to ingress |
| initContainers | object | `{}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. The dictionary item key will determine the order. Helm templates can be used. |
| lifecycle | object | `{}` | Configure the lifecycle for the main container |
| mariadb | object | See below | mariadb dependency configuration |
| mariadb.url | object | `{}` | can be used to make an easy accessable note which URLS to use to access the DB. |
| netshootImage | object | See below | netshoot specific configuration |
| netshootImage.pullPolicy | string | `"Always"` | Specify the netshoot image pull policy |
| netshootImage.repository | string | `"nicolaka/netshoot"` | Specify the netshoot image |
| netshootImage.tag | string | `"latest@sha256:d6942ec583d8e2818f5a5d7a71c303e861a70a11396ad9e9d25b355842e97589"` | Specify the netshoot image tag |
| networkPolicy | object | See below | Configure networkPolicy for the chart here. |
| networkPolicy.egress | list | `[]` | add or remove egress policies |
| networkPolicy.enabled | bool | `false` | Enables or disables the networkPolicy |
| networkPolicy.ingress | list | `[]` | add or remove egress policies |
| nodeSelector | object | `{}` |  |
| openvpnImage | object | See below | OpenVPN specific configuration |
| openvpnImage.pullPolicy | string | `"IfNotPresent"` | Specify the openvpn client image pull policy |
| openvpnImage.repository | string | `"dperson/openvpn-client"` | Specify the openvpn client image |
| openvpnImage.tag | string | `"latest@sha256:d174047b57d51734143325ad7395210643025e6516ba60a937e9319dbb462293"` | Specify the openvpn client image tag |
| persistence | object | See below | Configure persistence for the chart here. Additional items can be added by adding a dictionary key similar to the 'config' key. |
| persistence.config | object | See below | Default persistence for configuration files. |
| persistence.config.enabled | bool | `false` | Enables or disables the persistence item |
| persistence.config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.config.forceName | string | `""` | force the complete PVC name Will not add any prefix or suffix |
| persistence.config.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.config.nameOverride | string | `nil` | Override the name suffix that is used for this volume. |
| persistence.config.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.config.size | string | `"999Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to `SCALE-ZFS`, the default provisioner for TrueNAS SCALE is used. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.config.subPath | string | `nil` | Used in conjunction with `existingClaim`. Specifies a sub-path inside the referenced volume instead of its root |
| persistence.config.type | string | `"pvc"` | Sets the persistence type Valid options are: simplePVC, simpleHP, pvc, emptyDir, secret, configMap, hostPath or custom |
| persistence.configmap-example | object | See below | Example of a configmap mount |
| persistence.configmap-example.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.configmap-example.objectName | string | `"myconfig-map"` | Specify the name of the configmap object to be mounted |
| persistence.configmap-example.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.custom-mount | object | See below | Example of a custom mount |
| persistence.custom-mount.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.custom-mount.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.custom-mount.volumeSpec | object | `{}` | Define the custom Volume spec here [[ref]](https://kubernetes.io/docs/concepts/storage/volumes/) |
| persistence.host-dev | object | See below | Example of a hostPath mount [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) |
| persistence.host-dev.hostPath | string | `"/dev"` | Which path on the host should be mounted. |
| persistence.host-dev.hostPathType | string | `""` | Specifying a hostPathType adds a check before trying to mount the path. See Kubernetes documentation for options. |
| persistence.host-dev.mountPath | string | `""` | Where to mount the path in the main container. Defaults to the value of `hostPath` |
| persistence.host-dev.readOnly | bool | `true` | Specify if the path should be mounted read-only. |
| persistence.host-dev.setPermissions | bool | `false` | Automatic set permissions using chown and chmod |
| persistence.host-simple-dev | object | See below | Example of a Simple hostPath mount [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) |
| persistence.host-simple-dev.hostPathSimple | string | `"/dev"` | Which path on the host should be mounted. |
| persistence.host-simple-dev.hostPathType | string | `""` | Specifying a hostPathType adds a check before trying to mount the path. See Kubernetes documentation for options. |
| persistence.host-simple-dev.mountPath | string | `""` | Where to mount the path in the main container. Defaults to the value of `hostPath` |
| persistence.host-simple-dev.readOnly | bool | `true` | Specify if the path should be mounted read-only. |
| persistence.host-simple-dev.setPermissionsSimple | bool | `false` | Automatic set permissions using chown and chmod |
| persistence.secret-example | object | See below | Example of a secret mount |
| persistence.secret-example.defaultMode | int | `777` | define the default mount mode for the secret |
| persistence.secret-example.items | list | `[{"key":"username","path":"my-group/my-username"}]` | Define the secret items to be mounted |
| persistence.secret-example.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.secret-example.objectName | string | `"mysecret"` | Specify the name of the secret object to be mounted |
| persistence.secret-example.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.shared | object | See below | Create an emptyDir volume to share between all containers [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) |
| persistence.shared.medium | string | `nil` | Set the medium to "Memory" to mount a tmpfs (RAM-backed filesystem) instead of the storage medium that backs the node. |
| persistence.shared.sizeLimit | string | `nil` | If the `SizeMemoryBackedVolumes` feature gate is enabled, you can specify a size for memory backed volumes. |
| persistence.temp | object | See below | Create an emptyDir volume to share between all containers for temporary storage |
| persistence.temp.medium | string | `"Memory"` | Set the medium to "Memory" to mount a tmpfs (RAM-backed filesystem) instead of the storage medium that backs the node. |
| persistence.temp.sizeLimit | string | `nil` | If the `SizeMemoryBackedVolumes` feature gate is enabled, you can specify a size for memory backed volumes. |
| persistence.varlogs | object | See below | Create an emptyDir volume to share between all containers [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) |
| persistence.varlogs.medium | string | `nil` | Set the medium to "Memory" to mount a tmpfs (RAM-backed filesystem) instead of the storage medium that backs the node. |
| persistence.varlogs.sizeLimit | string | `nil` | If the `SizeMemoryBackedVolumes` feature gate is enabled, you can specify a size for memory backed volumes. |
| persistence.varrun | object | See below | Create an emptyDir volume to share between all containers [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) |
| persistence.varrun.medium | string | `"Memory"` | Set the medium to "Memory" to mount a tmpfs (RAM-backed filesystem) instead of the storage medium that backs the node. |
| persistence.varrun.sizeLimit | string | `nil` | If the `SizeMemoryBackedVolumes` feature gate is enabled, you can specify a size for memory backed volumes. |
| persistenceList | list | [] | Configure persistenceList for the chart here. Additional items can be added by adding a items similar to persistence |
| podAnnotations | object | `{}` |  |
| podAnnotationsList | list | `[]` | Set additional annotations on the pod |
| podLabels | object | `{}` | Set labels on the pod |
| podLabelsList | list | `[]` | Set additional labels on the pod |
| podSecurityContext | object | `{"fsGroup":568,"fsGroupChangePolicy":"OnRootMismatch","runAsGroup":568,"runAsUser":568,"supplementalGroups":[]}` | Configure the Security Context for the Pod |
| postgresql.enabled | bool | `false` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.url | object | `{}` | can be used to make an easy accessable note which URLS to use to access the DB. |
| postgresqlImage | object | See below | postgresql specific configuration |
| postgresqlImage.pullPolicy | string | `"IfNotPresent"` | Specify the postgresql image pull policy |
| postgresqlImage.repository | string | `"bitnami/postgresql"` | Specify the postgresql image |
| postgresqlImage.tag | string | `"14.1.0@sha256:9ba99644cbad69d08a9ad96656add5b498a57e692975878208d6ab32752eaa3c"` | Specify the postgresql image tag |
| priorityClassName | string | `nil` |  |
| probes | object | See below | Probe configuration -- [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.liveness.custom | bool | `false` | Set this to `true` if you wish to specify your own livenessProbe |
| probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| probes.liveness.path | string | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. If you selected `custom: true`, this field holds the definition of the livenessProbe. |
| probes.liveness.type | string | "TCP" | sets the probe type when not using a custom probe |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.readiness.custom | bool | `false` | Set this to `true` if you wish to specify your own readinessProbe |
| probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| probes.readiness.path | string | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. If you selected `custom: true`, this field holds the definition of the readinessProbe. |
| probes.readiness.type | string | "TCP" | sets the probe type when not using a custom probe |
| probes.startup | object | See below | Startup probe configuration |
| probes.startup.custom | bool | `false` | Set this to `true` if you wish to specify your own startupProbe |
| probes.startup.enabled | bool | `true` | Enable the startup probe |
| probes.startup.path | string | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. If you selected `custom: true`, this field holds the definition of the startupProbe. |
| probes.startup.type | string | "TCP" | sets the probe type when not using a custom probe |
| promtailImage | object | See below | promtail specific configuration |
| promtailImage.pullPolicy | string | `"IfNotPresent"` | Specify the promtail image pull policy |
| promtailImage.repository | string | `"ghcr.io/truecharts/promtail"` | Specify the promtail image |
| promtailImage.tag | string | `"v2.3.0@sha256:90019c5e4198d3253126fcc0c90db11b961ddf0a3c2906766f4611770beabdf2"` | Specify the promtail image tag |
| rbac | object | See below | Create a ClusterRole and ClusterRoleBinding |
| rbac.clusterRoleAnnotations | object | `{}` | Set labels on the ClusterRole |
| rbac.clusterRoleBindingAnnotations | object | `{}` | Set labels on the ClusterRoleBinding |
| rbac.clusterRoleBindingLabels | object | `{}` | Set Annotations on the ClusterRoleBinding |
| rbac.clusterRoleLabels | object | `{}` | Set Annotations on the ClusterRole |
| rbac.enabled | bool | `false` | Enables or disables the ClusterRole and ClusterRoleBinding |
| rbac.rules | object | `{}` | Set Rules on the ClusterRole |
| rbac.subjects | object | `{}` | Add subjects to the ClusterRoleBinding. includes the above created serviceaccount |
| redis | object | See below | Redis dependency configuration |
| redis.url | object | `{}` | can be used to make an easy accessable note which URLS to use to access the DB. |
| resources | object | `{"limits":{"cpu":"4000m","memory":"8Gi"},"requests":{"cpu":"10m","memory":"50Mi"}}` | Set the resource requests / limits for the main container. |
| schedulerName | string | `nil` | Allows specifying a custom scheduler name |
| secret | object | `{}` | Use this to populate a secret with the values you specify. Be aware that these values are not encrypted by default, and could therefore visible to anybody with access to the values.yaml file. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"add":[],"drop":[]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Configure the Security Context for the main container |
| service | object | See below | Configure the services for the chart here. Additional services can be added by adding a dictionary key similar to the 'main' service. |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.nameOverride | string | `nil` | Override the name suffix that is used for this service |
| service.main.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| service.main.ports.main.enabled | bool | `true` | Enables or disables the port |
| service.main.ports.main.nodePort | string | `nil` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| service.main.ports.main.port | string | `nil` | The port number |
| service.main.ports.main.primary | bool | `true` | Make this the primary port (used in probes, notes, etc...) If there is more than 1 service, make sure that only 1 port is marked as primary. |
| service.main.ports.main.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTPS and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.main.ports.main.targetPort | string | `nil` | Specify a service targetPort if you wish to differ the service port from the application port. If `targetPort` is specified, this port number is used in the container definition instead of the `port` value. Therefore named ports are not supported for this field. |
| service.main.portsList | list | See below | Configure additional Service port information here. |
| service.main.primary | bool | `true` | Make this the primary service (used in probes, notes, etc...). If there is more than 1 service, make sure that only 1 service is marked as primary. |
| service.main.selector | object | `{}` | Override default selector |
| service.main.type | string | `"ClusterIP"` | Set the service type Options: Simple(Loadbalancer), LoadBalancer, ClusterIP, NodePort |
| serviceAccount | object | See below | Create serviceaccount |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceList | list | See below | Configure additional services for the chart here. |
| termination.gracePeriodSeconds | int | `10` | Duration in seconds the pod needs to terminate gracefully -- [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle)] |
| termination.messagePath | string | `nil` | Configure the path at which the file to which the main container's termination message will be written. -- [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| termination.messagePolicy | string | `nil` | Indicate how the main container's termination message should be populated. Valid options are `File` and `FallbackToLogsOnError`. -- [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| tolerations | list | `[]` | Specify taint tolerations [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| topologySpreadConstraints | list | `[]` | Defines topologySpreadConstraint rules. [[ref]](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) |
| volumeClaimTemplates | list | `[]` | Used in conjunction with `controller.type: statefulset` to create individual disks for each instance. |
| wireguardImage | object | See below | WireGuard specific configuration |
| wireguardImage.pullPolicy | string | `"IfNotPresent"` | Specify the WireGuard image pull policy |
| wireguardImage.repository | string | `"ghcr.io/k8s-at-home/wireguard"` | Specify the WireGuard image |
| wireguardImage.tag | string | `"v1.0.20210914@sha256:3799349a9b09c689ffce45a4cedecc735af4fbc901e31d9cdbce1de1bc76be4c"` | Specify the WireGuard image tag |

All Rights Reserved - The TrueCharts Project
