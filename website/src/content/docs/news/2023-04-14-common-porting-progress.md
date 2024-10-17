---
slug: "news/common-porting-progress"
title: "Common Porting Progress"
authors: [ornias]
date: 2023-04-14
tags:
  - "2023"
---

We're close to releasing releasing the breaking port of another 50+ of our "Stable" train charts to the new common train. With this, we want to look back on a few things we've noticed with the initial release:

**Breaking Changes**

Generally speaking, any change in the first semver digit of our versions, means a _potentially_ breaking changes. How much this affects you, usually is effected by both the updates and your personal setup.
In this specific case, we want to make extra clear that 99.9% of our SCALE Apps will require manual reinstall.

For SCALE: This also means anything in databases is going to be completely wiped unless you've HeavyScript/TrueTool backups and/or have followed one or more of our community migration guides.
We should've been more clear that this behavior includes any and all databases and is not limited to MariaDB. Sadly enough this "wipe on App deletion" is a design in TrueNAS SCALE and not something we have influence over.

Our Helm users would, in most cases, with adapting their current values(.yaml) file in accordance with the new structure. though databases will still get wiped when doing the update.

**GPU Support**

GPU support took two snags:

- One was an obscure SCALE bug where dicts with one item didn't get rendered in the GUI (and it's output) accordingly. We've created a temporary patch for this to compensate
- The other was a minor permission issue, namely an additional group that should've been passed that got lost in development-translation from old to new common

Both are by now resolved and (being) rolled out.
In the future we plan to prevent at least the first issue more thoroughly by manually checking if the interface behaves correctly when doing big GUI changes.

**Addons**

We're still having some issues getting the Addons, primarily the VPN addon, behaving correctly. Mostly this is due to significantly increased hardening of our default kubernetes deployment.
We expect this to be fixed within a week or two, in the mean time users depending on our charts being used with VPN might want to wait a little.

**Discord**

There is some annoyance over the fact we use Discord for support. We're aware of this and are actually contemplating moving to another platform (as well). Sadly enough we do not have unlimited time available to work on the new common, release a new branding style _and_ expand support to another platform.
Users can expect a Discord alternative either end of 2023 or somewhere in 2024.

**Verbal Abuse**

A much less okay subject is the fact multiple of our staff members have suffered verbal abuse of varying degrees. Some have even led to cases where platform (reddit, discord etc.) needed to step in to take action.
While sometimes a staff response might seem a tad blunt or not to your liking, some of the things we've seen are completely and utterly unacceptable. We've a head moderator, JagrBombs if you've _any_ issue with a staff member.

We've taken steps to prevent needlessly exposing our staff to this. One of which is limiting our presence within certain communities on an as-needed basis.

**Conclusion**

In the end we've gotten a lot of feedback on the new release. Understandably many users are/where upset a reinstall was required. We want to highlight that we understand the frustration, but with the scope of these changes, a complete rewrite of our Common backend, we didn't have much choice on SCALE.
It's important to note, that users on SCALE cannot update via the update button in almost all cases, so users do _not_ have to worry about magically losing data by using the update button for this release.

Another topic we've seen mentioned was "but they say they are production ready", we want to be completely clear about this:
TrueCharts is not production ready at this time. In the future, after a separate announcement, _only_ our "Enterprise" train will be considered "production ready".
We want to highlight that this does not mean "stable" users can expect these breaking changes more often, as we don't plan to put another 700+ hours into the common chart any time soon. But it does mean, users should **NEVER** depend on our stable train for production, unless they do so on their own risk.

We wish all our users the best in going through these migrations and our support staff is available on Discord if you need any help.
