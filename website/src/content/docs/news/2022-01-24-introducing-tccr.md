---
slug: "news/introducing-tccr"
title: "Introducing: TrueCharts Container Repository"
authors: [ornias]
date: 2022-01-24
tags:
  - "2022"
---

The last year we’ve grown at an ever-increasing pace, doubling code and users every few months. Some issues could be fixed quickly and easily, while other issues were vastly more complex. One of those issues happened to be the convoluted mess of different container sources.

These container sources all had different tag formats, rate limits, downtimes, and one even decided to start deleting tags, leading to applications breaking. This, obviously, was not the experience we wanted our users to have.

Therefore, we’ve spent the better part of December setting up our own container distribution system. The TrueCharts Container Repository, or TCCR in short. TCCR is a combination of containers we’ve fully built ourselves and containers we mirror, screen and re-tag into a standardized format. Doing this also allowed us to ensure _all_ containers are available from multiple sources: GHCR, Quay and Dockerhub.

To achieve this, we’ve partnered with scarf.sh, which allows us to easily switch between container sources for our repository, while also giving us something new: metrics. We can finally see which containers are popular and which are not, but we can also see if there are people still using older versions of applications. This allows us to improve our decision-making process: which apps to work on and which older versions to keep supporting.

All of you have (under the hood), already been running TCCR and we’ve only had a handful of issues related to it. We’re happy to have created something that again, highlights us as the number 1 source for TrueNAS SCALE Applications.
