# Networking

TrueCharts contain a number of networking options, some super-easy, others quite-advanced. In this document we will try to give a general overview what the general configuration options are and what are their downside and upsides.

### General Choices

##### Host Networking

This option is considered to be an advanced option and is rarely needed. It connects the network-stack of the host to the App.

The reason this is not needed in most Apps, is because we already have great options to deal with most forms of network traffic and every maintainer has the goal to make sure you don't need this setting.

Please refer to the documentation of individual Apps or the Support-Discussions section on github, if you think you might need this setting in your specific usecase

##### ClusterIP

The "Basic" network mode, it create a special load-balancer called a "service" thats only available on the internal network between the Apps.

Don't think you can't connect to it though, because our [Reverse proxy](https://wiki.truecharts.org/general/reverse-proxy/) can forward most traffic for you!

##### NodePort

The name already makes clear what this one does: It connect to a port on your node (the PC hosting your App).

Its a special ClusterIP that forwards all traffic from a certain port on your host-system aka "node", directly to the service. However, it's also still a ClusterIP, so it's very well possible to use both the Reverse proxy and the NodePort, just not at the same port.

There are, however, multiple downsides to using nodeports:

- You can only pick ports above 9000
- You can not connect two Apps to the same port

##### LoadBalancer

Loadbalancer connects a service targetPort directly to the Host Network. However: it can do so in lower ranges than NodePort, making it a great solution for things like DNS servers.

There are, however, downsides to using LoadBalancer:

- You can not connect two Apps to the same port
