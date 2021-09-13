# Clustering

One of the eventual goals of SCALE is to run hyper-converged clusters based on ZFS, Gluster and Kubernetes.
While this is awesome, we like to highlight 3 ways of using Clustering with TrueCharts Apps in the future.

Currently no clustering is supported with TrueCharts yet, but we already make precautions during our design phase to implement clustering smoothly in the future.



##### Single-Pod Flexible

These Apps (can) only run a single instance of a pod at a time, so no "high available" setup available. However these Apps can still dynamically moved over to different nodes if a node fails, this should make sure the downtime stays relatively small.
These apps can also be "spread" over all nodes by kubernetes. This also means it's worth cutting big Single-Pod Apps into multiple smaller deployements, For example: n we prefer to deploy small database servers with every App (as those can more dynamically be spread over multiple nodes) over one Big single-pod Flexbile App.

Some examples of Apps that can not run with more than one pod at a time, even if we wanted to, are:

- Sonarr
- Lidarr
- Radarr
- Plex



##### Single-Pod non-flexible

These Apps can not be run with more than 1 pod at a time and on the other hand are bound to a node.
This means: Host-Down? Pod-Down!

Almost always this is caused by Apps being bound to a specific hardware setup.

*Examples:*

- zwavejs2mqtt
- HomeAssistant (depending on added hardware)
- Handbrake (depending on added hardware)



##### High Availability Apps

These Apps are designed to be the most resiliant of all, they can handle node failures and pod failures without any issue, because they always run multiple Pods at once that fill in once pods or nodes start failing.

Because these Apps are also the most complicated of all, we try to limit them to key-area's of the TrueCharts ecosystem that can not be cut into smaller pieces (Single-Pod Flexible) easily. Like: Ingress and Monitoring.

*Examples:*


- Traefik
