---
slug: "news/scale-deprecation"
title: "Deprecation of TrueNAS SCALE Apps"
authors: [ornias]
date: 2024-05-30
tags:
  - "2024"
---

Like many of you, we've been made aware by the decision of iX-Systems to remove Kubernetes from TrueNAS SCALE Electric-Eel onwards.
We're very saddened by this news, as we had some awesome plans in store for all our users, including those on TrueNAS SCALE.

From integrations with popular Kubernetes tools, to our VPN addon and even our latest addition of integrated VolSync S3 backup support,
the last few years we've spent hundreds of hours pushing the boundaries of what is possible with Helm charts **and we will continue to do so**.

While we fully agree that iX should offer the option to use docker-compose in addition to Kubernetes-based "custom-app"s, the way this sun-setting without deprecation has been handled, is not acceptable to us.
It goes against every fiber of our being, as we prefer to collaborate on moving our loved platforms forward.

We view that both Kubernetes and Docker-Compose have a place, with that place not being mutually exclusive. Sadly enough, iX-Systems does not share that view.
It's a loss-loss situation, where SCALE users will have to trade the loss of TrueCharts with the option of copying-in their own compose files.

A situation that, from our point of view, isn't, and has never been, needed. But it's the cards we've been dealt.

## Our way forward

As always, we're committed 100% to our users and **will** help them find solutions.

Currently, we're exploring multiple strategies by which you will be able to keep using our trusted TrueCharts Charts, even combined with your current TrueNAS SCALE Storage.
We've learned a lot from our smooth DragonFish migration last month and we're fully confident we can offer an experience that satisfies our users!

Our time-frame is to have an initial BETA for migration going before 01-07-2024, after which we want to polish and automate the process as much as possible based on user feedback.

## Our goodbye

Our goodbyes for TrueCharts on SCALE Apps are bitter-sweet;
while we have had a great time working with some people over at iX-Systems, we also don't see eye-to-eye on many things.

We shall _always_ stand with our users. Which means we also will focus on the way forward from now on, in which TrueNAS SCALE Apps will not be featured and we will instead focus on our other supported platforms and migration options.

We want to thank the TrueNAS community for their constant feedback during the years that TrueCharts as SCALE Apps lasted.
We specifically want to thank Waqar Ahmed for the many hours spent polishing the original Apps system and Morgan Littlewood for his continued vision of what TrueNAS SCALE could be.
