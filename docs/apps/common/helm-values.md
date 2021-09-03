# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our Common Chart.
This chart is used by a lot of our Apps to provide sane defaults and logic.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers | list | `[]` | Specify any additional containers here. Yaml will be passed in to the Pod as-is. |
| affinity | object | `{}` | Defines affinity constraint rules. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| args | list | `[]` | Override the args for the default container |
| autoscaling | object | <disabled> | Add a Horizontal Pod Autoscaler |
| command | list | `[]` | Override the command(s) for the default container |
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
| deviceList | list | [] | Configure persistenceList for the chart here. Used to create an additional GUI element in SCALE for mounting USB devices Additional items can be added by adding a items similar to persistence |
| dnsConfig | object | `{}` | Optional DNS settings, configuring the ndots option may resolve nslookup issues on some Kubernetes setups. |
| dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| enableServiceLinks | bool | `false` | Enable/disable the generation of environment variables for services. [[ref]](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service) |
| env | object | `{}` | Main environment variables. Template enabled. Syntax options: A) TZ: UTC B) PASSWD: '{{ .Release.Name }}' C) PASSWD:      envFrom:        ... |
| envFrom | list | `[]` |  |
| envTpl | object | `{}` |  |
| envValueFrom | object | `{}` |  |
| global.fullnameOverride | string | `nil` | Set the entire name definition |
| global.nameOverride | string | `nil` | Set an override for the prefix of the fullname |
| hostAliases | list | `[]` | Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames. [[ref]](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| hostNetwork | bool | `false` | When using hostNetwork make sure you set dnsPolicy to `ClusterFirstWithHostNet` |
| hostname | string | `nil` | Allows specifying explicit hostname setting |
| image.pullPolicy | string | `nil` | image pull policy |
| image.repository | string | `nil` | image repository |
| image.tag | string | `nil` | image tag |
| ingress | object | See below | Configure the ingresses for the chart here. Additional ingresses can be added by adding a dictionary key similar to the 'main' ingress. |
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
| initContainers | list | `[]` | Specify any initContainers here. Yaml will be passed in to the Pod as-is. |
| lifecycle | object | `{}` | Configure the lifecycle for the main container |
| networkPolicy | object | See below | Configure networkPolicy for the chart here. |
| networkPolicy.egress | list | `[]` | add or remove egress policies |
| networkPolicy.enabled | bool | `false` | Enables or disables the networkPolicy |
| networkPolicy.ingress | list | `[]` | add or remove egress policies |
| nodeSelector | object | `{}` |  |
| persistence | object | See below | Configure persistence for the chart here. Additional items can be added by adding a dictionary key similar to the 'config' key. |
| persistence.config | object | See below | Default persistence for configuration files. |
| persistence.config.enabled | bool | `false` | Enables or disables the persistence item |
| persistence.config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.config.forceName | string | `""` | force the complete PVC name Will not add any prefix or suffix |
| persistence.config.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.config.nameOverride | string | `nil` | Override the name suffix that is used for this volume. |
| persistence.config.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.config.size | string | `"1Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to `SCALE-ZFS`, the default provisioner for TrueNAS SCALE is used. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.config.subPath | string | `nil` | Used in conjunction with `existingClaim`. Specifies a sub-path inside the referenced volume instead of its root |
| persistence.config.type | string | `"pvc"` | Sets the persistence type Valid options are pvc, emptyDir, hostPath or custom |
| persistence.custom-mount | object | See below | Example of a custom mount |
| persistence.custom-mount.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.custom-mount.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.custom-mount.volumeSpec | object | `{}` | Define the custom Volume spec here [[ref]](https://kubernetes.io/docs/concepts/storage/volumes/) |
| persistence.host-dev | object | See below | Example of a hostPath mount [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) |
| persistence.host-dev.hostPath | string | `"/dev"` | Which path on the host should be mounted. |
| persistence.host-dev.hostPathType | string | `""` | Specifying a hostPathType adds a check before trying to mount the path. See Kubernetes documentation for options. |
| persistence.host-dev.mountPath | string | `nil` | Where to mount the path in the main container. Defaults to the value of `hostPath` |
| persistence.host-dev.readOnly | bool | `true` | Specify if the path should be mounted read-only. |
| persistence.shared | object | See below | Create an emptyDir volume to share between all containers [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) |
| persistence.shared.medium | string | `nil` | Set the medium to "Memory" to mount a tmpfs (RAM-backed filesystem) instead of the storage medium that backs the node. |
| persistence.shared.sizeLimit | string | `nil` | If the `SizeMemoryBackedVolumes` feature gate is enabled, you can specify a size for memory backed volumes. |
| persistenceList | list | [] | Configure persistenceList for the chart here. Additional items can be added by adding a items similar to persistence |
| podAnnotations | object | `{}` |  |
| podAnnotationsList | list | `[]` | Set additional annotations on the pod |
| podLabels | object | `{}` | Set labels on the pod |
| podLabelsList | list | `[]` | Set additional labels on the pod |
| podSecurityContext | object | `{}` | Configure the Security Context for the Pod |
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
| rbac | object | See below | Create a ClusterRole and ClusterRoleBinding |
| rbac.clusterRoleAnnotations | object | `{}` | Set labels on the ClusterRole |
| rbac.clusterRoleBindingAnnotations | object | `{}` | Set labels on the ClusterRoleBinding |
| rbac.clusterRoleBindingLabels | object | `{}` | Set Annotations on the ClusterRoleBinding |
| rbac.clusterRoleLabels | object | `{}` | Set Annotations on the ClusterRole |
| rbac.enabled | bool | `false` | Enables or disables the ClusterRole and ClusterRoleBinding |
| rbac.rules | object | `{}` | Set Rules on the ClusterRole |
| rbac.subjects | object | `{}` | Add subjects to the ClusterRoleBinding. includes the above created serviceaccount |
| resources | object | `{}` | Set the resource requests / limits for the main container. |
| schedulerName | string | `nil` | Allows specifying a custom scheduler name |
| secret | object | `{}` | Use this to populate a secret with the values you specify. Be aware that these values are not encrypted by default, and could therefore visible to anybody with access to the values.yaml file. |
| securityContext | object | `{"allowPrivilegeEscalation":true,"privileged":false,"readOnlyRootFilesystem":false}` | Configure the Security Context for the main container |
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
| service.main.type | string | `"ClusterIP"` | Set the service type |
| serviceAccount | object | See below | Create serviceaccount |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceList | list | See below | Configure additional services for the chart here. |
| termination.gracePeriodSeconds | int | `10` | Duration in seconds the pod needs to terminate gracefully -- [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle)] |
| termination.messagePath | string | `nil` | Configure the path at which the file to which the main container's termination message will be written. -- [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| termination.messagePolicy | string | `nil` | Indicate how the main container's termination message should be populated. Valid options are `File` and `FallbackToLogsOnError`. -- [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| tolerations | list | `[]` | Specify taint tolerations [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| volumeClaimTemplates | list | `[]` | Used in conjunction with `controller.type: statefulset` to create individual disks for each instance. |

All Rights Reserved - The TrueCharts Project
