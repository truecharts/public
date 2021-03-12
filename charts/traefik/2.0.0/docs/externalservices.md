# External Service

Some users may want to use Traefik for things that are not part of a TrueNAS SCALE App. For these users we support "External Services".

"External Services" are an advanced configuration option that lets you forward Traefik from Ingress to a service outside of the Container network. For example: A TrueNAS Host system. This allows you to, for example, use the same SSL certificates for both services inside and outside the TrueNAS SCALE App ecosystem.

##### Configuration

External Services require both the IP Adress and Port of the service you want to forward. These will internally create a special 'service' that recieves traffic on the same ports (internally) and forwards it to the external service.

Additionally it creates an ingress which forwards traffic to the special forwarding service.
