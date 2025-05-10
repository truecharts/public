---
sidebar:
  order: 2
title: FluxCD Webhook
---

:::caution[Disclaimer]

This guide isnt covered by the Support Policy and is considered more advanced.
If you face issues feel free to open a thread in the appropiate Channel in our Discord server.

:::

## Prerequisites

- Having a running Kubernetes cluster
- Bootstrapped fluxcd
- Knowledge on how to add charts/kubernetes resources with fluxcd
- Usage of an ingress to make the webhook accessible from outside your network

## Initial Setup

- Create a new folder called `webhooks` inside the `flux-system` folder.
- Add a subfolder called `github`
- Add the necessary kustomization to the `webhooks` folder for the github directory
- Next we will need 3 files inside the github folder:

  ```yaml
    // receiver.yaml

    apiVersion: notification.toolkit.fluxcd.io/v1
    kind: Receiver
    metadata:
      name: github-receiver
      namespace: flux-system
    spec:
      type: github
      events:
        - "ping"
        - "push"
      secretRef:
        name: github-webhook-token
      resources:
        - kind: GitRepository
          name: cluster
          namespace: flux-system

  ```

  ```yaml
  // webhook.secret.yaml

  apiVersion: v1
  kind: Secret
  metadata:
      name: github-webhook-token
      namespace: flux-system
  stringData:
      token: YOURSECRETKEY

  ```

  ```yaml
  // ingress.yaml

  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: webhook-receiver
    namespace: flux-system
    annotations:
        cert-manager.io/cluster-issuer: domain-1-le-prod
        cert-manager.io/private-key-rotation-policy: Always
        traefik.ingress.kubernetes.io/router.entrypoints: websecure
        traefik.ingress.kubernetes.io/router.middlewares: traefik-chain-basic@kubernetescrd
        traefik.ingress.kubernetes.io/router.tls: "true"
  spec:
    rules:
    - host: flux-webhook.${DOMAIN_0}
      http:
        paths:
        - pathType: Prefix
          path: /
          backend:
            service:
              name: webhook-receiver
              port:
                number: 80
    tls:
      - hosts:
        - flux-webhook.${DOMAIN_0}
        secretName: flux-webhook-tls-0

  ```

- Add the necessary kustomization to add all 3 of those files to your cluster

## Create your Webhook Token

- Run the following command to generate your Webhook Token

  ```bash
  TOKEN=$(head -c 12 /dev/urandom | shasum | cut -d ' ' -f1)
  echo $TOKEN
  ```

- Replace `YOURSECRETKEY` with your generated Webhook Token
- Make sure to run `clustertool encrypt` to encrypt your files
- Push changes to your cluster before continuing

## Get Receiver URL

After pushing the changes to your cluster and waiting for reconcile.
Run the following command to get your receiver url:

```bash

kubectl -n flux-system get receiver/github-receiver

```

Output should look something like this:

```bash

NAME     READY   STATUS
github-receiver   True    Receiver initialised with URL: /hook/bed6d00b5555b1603e1f59b94d7fdbca58089cb5663633fb83f2815dc626d92b
```

Next you will have to add your domain and subdomain to it.
Example

```yaml
https://flux-webhook.mydomain.com/hook/bed6d00b5555b1603e1f59b94d7fdbca58089cb5663633fb83f2815dc626d92b
```

:::warning

Make sure the flux-webhook.mydomain.com is accessible from outside your network. Otherwise it will not work.

:::

## Adding the webhook to github

- Open your cluster repository on Github and go to settings
- Next select `Webhooks` on the left menu
- Click `Add webhook`
- Add your Receiver Url into the `Payload URL`
- Select the `Content type` to `application/x-www-form-urlencoded`
- Add your Webhook Token to the `Secret` field
- Leave the rest of the options default
- Click `Add webhook` to finish the creation

## Finishing Steps

You should now see your Webhook in the Github Webhook Menu.
Click on it and check the `Recent Deliveries` if the test was successfull

If it worked. Your done and now each push to the main branch should trigger a reconcile on your cluster.
