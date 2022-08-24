# F.A.Q. (Frequently Asked Questions)

## Why PVC is recommended over HostPath?

We recommend using PVC for `config` storage, because it allows easily to rollback your app
in case of a failed update. Also it's worth mentioning that is the only storage option for `config`
we can offer active support at the time. You can of course use host path for your `media` files.

## Do we support ACL's for HostPath storage?

While it technically is perfectly possible for *most* Charts/Apps,
We currently advise people to NOT use ACL's for host path storage.
We cannot guide each user through setting up their ACL's for each chart.
Apart from a few exceptions, user 568 (apps) must have access to their host path storage.

## Are there Ingress requirement for certain apps?

Certain applications require ingress to work correctly due to security reasons.
Few example are:

- Vaultwarden
- Nextcloud
- Monica
- Recipes

## Do we support other proxies and LoadBalancers in front of Traefik?

Not supported for standard support channels. This includes cloudflare proxy

## What is the meaning of Advanced/Expert Checkboxes (Networking, Storage, etc)?

This options are only there for experienced people and out of basic support realm.
Checking those boxes and/or enabling things such as host-networking may break your app
and require a reinstall for it to work properly.

## My Chart is asking for a default Password, what is it?

We use upstream containers. If the password is not on our website,
please refer to the upstream container sources we list on the website instead.

## My Chart application has had an upstream update, but the chart is not updated yet?

It takes a few days for our automation tools to pick up updates, please sit tight.
Please only report missed updates when 7 days have passed after the new *container(!)* has become available.

## Isn't there more documentation for an chart?

If it's not on our website or the discord, we (sadly) do not.
There might be other sources for documentation however!
It's of no value to ask about it, because if we had, it would already be there...

## I would like another application to be added, how do I get it?

Please file an issue on [Github](https://github.com/truecharts/charts) about it,
after checking to make sure it isn't requested already.
Keep in mind, that a request for an app is not guaranteed to be added.
Request is only there for developers to know what people would like to see added.

## How do I know if there are Breaking Changes?

TrueCharts uses Semantic Versioning on the aspects of the chart that TrueCharts has changed.
Some upstream **containers** use `latest` tags or poor versioning schemes so updates aren't always
clear if they contain breaking changes, but be sure to check the **changelog** for each chart before updating.

## How do I tell that this update is a Major and potentially breaking change?

You should always check **BOTH** `chart` version **AND** `container` version.
As both could have breaking changes on major updates independently.
Major changes are marked by a change in the first digit of the version. eg. 13.2.1 → 14.0.0.

## What to do before trying a breaking change update?

Take backups beforehand with Truetool.

## Does truetool auto-updates major changes?

Depending on the flags you used. We recommend to **NOT** use the `-U` flag.
If you use it, it will update to major version changes.

## Do you offer support for breaking changes?

### Breaking change in chart

We try to help on a best effort basis, but support will be limited as they are
expected to be more-or-less breaking and we cannot control all scenarios.

### Breaking change in container

We can try to look on your setup/logs and see if there is anything obvious,
but apart from that we can't offer support for a product that we did not develop.
You most likely will have to reach to the upstream support channels for that.

## Why is my OpenVPN password not working?

Don't use $ in your passwords, it won't work due to an upstream
[bug](https://github.com/dperson/openvpn-client/issues/376) in OpenVPN container
