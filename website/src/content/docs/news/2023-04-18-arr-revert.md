---
slug: "news/arr-revert"
title: "*Arr revert"
authors: [ornias]
date: 2023-04-18
tags:
  - "2023"
---

While most of our migration to new common worked out reasonably well, we've received many issues with regards to another change.
Our change for the "Arr" Apps, like Radarr and Prowlarr, to their new Postgresql backend ended up terribly.

We did not correctly anticipate how hard that migration was going to be for our users and also encountered a number of bugs and design mistakes for those Apps.
After long consideration and attempted bug-fixing, we've decided to revert the move to Postgreqsql for the "Arr" Apps, back to sqlite.

This also means that after next change (which will be flagged as breaking due to moving back the database change) you will also be able to neatly import your "Arr" App backups from old common again.

We've very sorry for this revert and we completely understand that we should've done considerably more research before implementing this move to a different database version.
The revert should be made available shortly, within 24 hours.
